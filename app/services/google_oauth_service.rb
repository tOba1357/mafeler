class GoogleOauthService
  class << self
    require 'google/apis/oauth2_v2'
    require 'google/api_client/client_secrets'

    def auth_url(redirect_url)
      client_secrets = Google::APIClient::ClientSecrets.new(JSON.parse(ENV['GOOGLE_CLIENT_SECRETS']))
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        scope: 'https://www.googleapis.com/auth/userinfo.profile',
        redirect_uri: redirect_url,
        additional_parameters: {
          access_type: 'offline',
          prompt: 'consent',
          include_granted_scopes: 'true'
        }
      )
      auth_client.authorization_uri.to_s
    end

    def auth(code, redirect_url)
      client_secrets = Google::APIClient::ClientSecrets.new(JSON.parse(ENV['GOOGLE_CLIENT_SECRETS']))
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        scope: 'https://www.googleapis.com/auth/userinfo.profile',
        redirect_uri: redirect_url
      )
      auth_client.code = code
      tokens = auth_client.fetch_access_token!
      service = Google::Apis::Oauth2V2::Oauth2Service.new
      service.authorization = auth_client
      id = service.get_userinfo.id
      oauth = GoogleOauth.find_by(uid: id)
      if oauth.blank?
        User.transaction do
          user = User.create
          user.create_google_oauth(
            uid: id,
            refresh_token: tokens['refresh_token']
          )
        end
      else
        oauth.user
      end
    end
  end
end
