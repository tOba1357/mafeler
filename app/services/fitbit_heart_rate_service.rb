class FitbitHeartRateService
  class << self
    def import_heart_rates(fitbit_account, start_date = nil, end_date = Date.today)
      if start_date.nil?
        latest = fitbit_account.fitbit_heart_rates.order(date: :DESC).limit(1).first
        start_date = latest.date - 1.day if latest.present?
      end
      heart_rates = get_heart_rate(fitbit_account, start_date, end_date)
      models = heart_rates.map{|heart_rate| build_model(fitbit_account, heart_rate)}
      columns = FitbitHeartRate.columns.map(&:name).select{|column| not %w(id created_at updated_at).include?(column)}
      FitbitHeartRate.import models, on_duplicate_key_update: {conflict_target: [:fitbit_account_id, :date], columns: columns}
    end

    def get_heart_rate(fitbit_account, start_date = nil, end_date = Date.today)
      access_token = FitbitService.get_access_token fitbit_account
      heart_rates = []
      while true
        param_start_date = start_date.nil? ? end_date - 100.day : [start_date, end_date - 100.day].max
        url = URI.parse("https://api.fitbit.com/1/user/#{fitbit_account.fitbit_user_id}/activities/heart/date/#{param_start_date}/#{end_date}.json")
        req = Net::HTTP::Get.new(url.to_s)
        req['Authorization'] = "Bearer #{access_token}"
        res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
        case res
        when Net::HTTPSuccess
          res_heart_rates = JSON.parse(res.body)['activities-heart']
            .select {|heart_rate|
              heart_rate['value']['heartRateZones'].first.has_key?('minutes')
            }
          heart_rates.concat res_heart_rates
          break if start_date.nil? and res_heart_rates.blank?
          end_date = end_date - 101.day
          break if start_date.present? and start_date > end_date
        else
          raise "failed: get heart rate. #{res.body}"
        end
      end
      heart_rates
    end

    def build_model(fitbit_account, data)
      out_of_range = data['value']['heartRateZones'].find{|v| v['name'] == 'Out of Range'}
      fat_burn = data['value']['heartRateZones'].find{|v| v['name'] == 'Fat Burn'}
      cardio = data['value']['heartRateZones'].find{|v| v['name'] == 'Cardio'}
      peak = data['value']['heartRateZones'].find{|v| v['name'] == 'Peak'}
      fitbit_account.fitbit_heart_rates.build(
        {
          date: data['dateTime'],
          out_of_range_minutes: out_of_range['minutes'],
          fat_burn_minutes: fat_burn['minutes'],
          cardio_minutes: cardio['minutes'],
          peak_minutes: peak['minutes'],
          out_of_range_calories_out: out_of_range['caloriesOut'],
          fat_burn_calories_out: fat_burn['caloriesOut'],
          cardio_calories_out: cardio['caloriesOut'],
          peak_calories_out: peak['caloriesOut'],
          resting_heart_rate: data['value']['restingHeartRate'],
        }
      )
    end

  end
end
