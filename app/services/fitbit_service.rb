class FitbitService
  class << self
    def create_sleep_data(fitbit_account, start_date = nil, end_date = Date.today)
      sleeps_json = get_sleep_data(fitbit_account, start_date, end_date)
      sleeps = sleeps_json.map {|sleep| build_sleep(fitbit_account, sleep)}
      columns = FitbitSleep.columns.map(&:name).select {|column| not %w(id created_at updated_at).include?(column)}
      FitbitSleep.import sleeps, on_duplicate_key_update: {conflict_target: [:log_id], columns: columns}
      sleeps
    end

    def build_sleep(fitbit_account, data)
      fitbit_account.fitbit_sleeps.build(
          {
              date: data['dateOfSleep'],
              log_id: data['logId'],
              start_time: data['startTime'],
              end_time: data['endTime'],
              efficiency: data['efficiency'],
              minutes_after_wakeup: data['minutesAfterWakeup'],
              minutes_asleep: data['minutesAsleep'],
              minutes_awake: data['minutesAwake'],
              deep_count: data.dig('levels', 'summary', 'deep', 'count'),
              deep_minutes: data.dig('levels', 'summary', 'deep', 'minutes'),
              light_count: data.dig('levels', 'summary', 'light', 'count'),
              light_minutes: data.dig('levels', 'summary', 'light', 'minutes'),
              rem_count: data.dig('levels', 'summary', 'rem', 'count'),
              rem_minutes: data.dig('levels', 'summary', 'rem', 'minutes'),
              wake_count: data.dig('levels', 'summary', 'wake', 'count'),
              wake_minutes: data.dig('levels', 'summary', 'wake', 'minutes'),
          }
      )
    end

    def get_sleep_data(fitbit_account, start_date = nil, end_date = Date.today)
      fitbit_account = fitbit_account
      access_token = get_access_token fitbit_account
      sleeps = []
      while true
        param_start_date = start_date.nil? ? end_date - 100.day : [start_date, end_date - 100.day].max
        url = URI.parse("https://api.fitbit.com/1.2/user/#{fitbit_account.fitbit_user_id}/sleep/date/#{param_start_date}/#{end_date}.json")
        req = Net::HTTP::Get.new(url.to_s)
        req['Authorization'] = "Bearer #{access_token}"
        res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
        case res
        when Net::HTTPSuccess
          res_sleeps = JSON.parse(res.body)['sleep']
          sleeps.concat res_sleeps
          break if start_date.nil? and res_sleeps.blank?
          end_date = end_date - 101.day
          break if start_date.present? and start_date > end_date
        else
          raise '睡眠データの取得に失敗しました。'
        end
      end
      sleeps
    end

    def get_access_token(fitbit_account)
      url = URI.parse('https://api.fitbit.com/oauth2/token')
      req = Net::HTTP::Post.new(url.to_s)
      req['Authorization'] = 'Basic ' + Base64.strict_encode64("#{ENV['FITBIT_CLIENT_ID']}:#{ENV['FITBIT_CLIENT_SECRET']}")
      req.set_form_data(
          {
              grant_type: 'refresh_token',
              refresh_token: fitbit_account.refresh_token
          }
      )
      res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
      case res
      when Net::HTTPSuccess
        res_json = JSON.parse(res.body)
        fitbit_account.update_column(:refresh_token, res_json['refresh_token'])
        return res_json['access_token']
      else
        Rollbar.error(res.message, res)
        raise 'Access Token の取得に失敗しました。'
      end
    end
  end
end
