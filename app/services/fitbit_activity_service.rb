class FitbitActivityService
  class << self
    def import_activities(fitbit_account)
      latest = fitbit_account.fitbit_activities.order(start_time: :desc).limit(1).first
      start_time = latest.present? ? latest.start_time - 1.day : nil
      activities = get_activities(fitbit_account, start_time)
      models = activities.map {|activity| build_model(fitbit_account, activity)}
      columns = FitbitActivity.columns.map(&:name).select {|column| not %w(id created_at updated_at).include?(column)}
      FitbitActivity.import models, on_duplicate_key_update: {conflict_target: [:log_id], columns: columns}
    end

    def get_activities(fitbit_account, started_at = nil)
      access_token = FitbitService.get_access_token fitbit_account
      activities = []
      before_date = Date.today
      url = URI.parse("https://api.fitbit.com/1/user/#{fitbit_account.fitbit_user_id}/activities/list.json")
      params = {
        beforeDate: before_date,
        sort: 'desc',
        limit: 20,
        offset: 0,
      }
      url.query = URI.encode_www_form(params)
      while true
        req = Net::HTTP::Get.new(url.to_s)
        req['Authorization'] = "Bearer #{access_token}"
        res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
        case res
        when Net::HTTPSuccess
          res_json = JSON.parse(res.body)
          res_activity = res_json['activities']
          activities.concat res_activity
          break if started_at.present? && res_activity.present? && Time.zone.parse(res_activity.last['startTime']) < started_at
          next_url = res_json.dig('pagination', 'next')
          break if next_url.blank?
          url = URI.parse(next_url)
        else
          raise "failed: get activities. #{res.body}"
        end
      end
      activities
    end

    def build_model(fitbit_account, data)
      model = fitbit_account.fitbit_activities.build(
        {
          start_time: data['startTime'],
          log_id: data['logId'],
          activity_type_id: data['activityTypeId'],
          activity_name: data['activityName'],

          # activityLevel
          sedentary_minutes: data['activityLevel'].find {|activity_level| activity_level['name'] == 'sedentary'}['minutes'],
          lightly_minutes: data['activityLevel'].find {|activity_level| activity_level['name'] == 'lightly'}['minutes'],
          fairly_minutes: data['activityLevel'].find {|activity_level| activity_level['name'] == 'fairly'}['minutes'],
          very_minutes: data['activityLevel'].find {|activity_level| activity_level['name'] == 'very'}['minutes'],

          active_duration: data['activeDuration'],
          duration: data['duration'],
          average_heart_rate: data['averageHeartRate'],
          calories: data['calories'],
          steps: data['steps'] || 0,
        }
      )
      heart_rate_zones = data['heartRateZones']
      if heart_rate_zones.present?
        model['out_of_range_minutes'] = heart_rate_zones.find {|heart_rate_zone| heart_rate_zone['name'] == 'Out of Range'}['minutes']
        model['fat_burn_minutes'] = heart_rate_zones.find {|heart_rate_zone| heart_rate_zone['name'] == 'Fat Burn'}['minutes']
        model['cardio_minutes'] = heart_rate_zones.find {|heart_rate_zone| heart_rate_zone['name'] == 'Cardio'}['minutes']
        model['peak_minutes'] = heart_rate_zones.find {|heart_rate_zone| heart_rate_zone['name'] == 'Peak'}['minutes']
      end
      model
    end
  end
end
