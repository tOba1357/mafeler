class FitbitSleepService
  class << self
    def import_sleep(fitbit_account, start_date = nil, end_date = Date.today)
      if start_date.nil?
        latest_fitbit_sleep = fitbit_account.fitbit_sleeps.order(end_time: :DESC).limit(1).first
        if latest_fitbit_sleep.present?
          start_date = latest_fitbit_sleep.end_time - 1.day
          start_date = start_date.to_date
        end
      end
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
      access_token = FitbitService.get_access_token fitbit_account
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
  end
end
