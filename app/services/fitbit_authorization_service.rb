class FitbitAuthorizationService
  def self.authorization(user, code, redirect_url)
    url = URI.parse('https://api.fitbit.com/oauth2/token')
    req = Net::HTTP::Post.new(url.to_s)
    req['Authorization'] = 'Basic ' + Base64.strict_encode64("#{ENV['FITBIT_CLIENT_ID']}:#{ENV['FITBIT_CLIENT_SECRET']}")
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req.set_form_data(
      {
        client_id: ENV['FITBIT_CLIENT_ID'],
        grant_type: 'authorization_code',
        redirect_uri: redirect_url,
        code: code
      }
    )
    res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
    case res
    when Net::HTTPSuccess
      body = JSON.parse res.body
      user.create_fitbit_account(
        {
          refresh_token: body['refresh_token'],
          fitbit_user_id: body['user_id']
        }
      )
      true
    else
      false
    end
  end
end
