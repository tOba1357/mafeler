class NatureRemoService
  class << self
    def create_nature_remo(user, access_token)
      me = NatureRemoService.get('https://api.nature.global/1/users/me', access_token)
      nature_remo = NatureRemo.new(
        user: user,
        access_token: access_token,
        uid: me['id'],
        nickname: me['nickname']
      )
      nature_remo.save!
      nature_remo
    end

    def save_sensor_values(nature_remo)
      devices = NatureRemoService.get('https://api.nature.global/1/devices', nature_remo.access_token)
      return if devices.blank?
      # TODO: select device or can save multiple devices
      device = devices.first
      events = device['newest_events']
      # FIXME: check duplicate unique key before save
      begin
        nature_remo.temperatures.create(value: events['te']['val'], created_at: events['te']['created_at'])
      rescue => e
        Rails.logger.warn(e)
      end
      begin
        nature_remo.humidities.create(value: events['hu']['val'], created_at: events['hu']['created_at'])
      rescue => e
        Rails.logger.warn(e)
      end
      begin
        nature_remo.illuminations.create(value: events['il']['val'], created_at: events['il']['created_at'])
      rescue => e
        Rails.logger.warn(e)
      end
    end

    def get(url, access_token)
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.to_s)
      req['Authorization'] = "Bearer #{access_token}"
      res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
      case res
      when Net::HTTPSuccess
        body = JSON.parse(res.body)
        return body
      else
        raise "failed: get from #{url}. #{res.body}"
      end
    end
  end
end
