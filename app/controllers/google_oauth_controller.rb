class GoogleOauthController < ApplicationController
  skip_before_action :logged_in_user
  def auth
    return redirect_to root_path if logged_in?
    redirect_to GoogleOauthService.auth_url callback_url
  end

  def callback
    user = GoogleOauthService.auth(params[:code], callback_url)
    log_in user
    redirect_to root_path
  end

  private
  def callback_url
    oauth2_google_callback_url
  end
end
