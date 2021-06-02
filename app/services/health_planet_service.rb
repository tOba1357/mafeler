class HealthPlanetService
  class << self
    def authorization(user, code, redirect_url)
      url = URI.parse('https://www.healthplanet.jp/oauth/token')
      req = Net::HTTP::Post.new(url.to_s)
      req.set_form_data(
        {
          client_id: ENV['HEALTH_PLANET_CLIENT_ID'],
          client_secret: ENV['HEALTH_PLANET_CLIENT_SECRET'],
          redirect_uri: redirect_url,
          code: code,
          grant_type: 'authorization_code',
        }
      )
      res = Net::HTTP.start(url.host, use_ssl: true) { |http| http.request(req) }
      case res
      when Net::HTTPSuccess
        body = JSON.parse res.body
        return false if body['error'].present?
        user.create_health_planet({refresh_token: body['refresh_token']})
        true
      else
        false
      end
    end

    def get_access_token(health_planet)
      url = URI.parse('https://www.healthplanet.jp/oauth/token')
      req = Net::HTTP::Post.new(url.to_s)
      req.set_form_data(
        {
          client_id: ENV['HEALTH_PLANET_CLIENT_ID'],
          client_secret: ENV['HEALTH_PLANET_CLIENT_SECRET'],
          grant_type: 'refresh_token',
          refresh_token: health_planet.refresh_token,
          redirect_uri: 'https://www.healthplanet.jp/success.html',
        }
      )
      res = Net::HTTP.start(url.host, use_ssl: true) { |http| http.request(req) }
      case res
      when Net::HTTPSuccess
        return JSON.parse(res.body)['access_token']
      else
        Rollbar.error(res.body, res)
        raise 'Access Token の取得に失敗しました。'
      end
    end
  end
end
