class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :better_errors_hack, if: -> { Rails.env.development? }
  before_action :logged_in_user

  include SessionsHelper

  private
  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
  end

  def logged_in_user
    if current_user.nil?
      render json: 'ログインしてください', status: 401
    end
  end

  def health_planet
    @health_planet ||= current_user.health_planet
  end
end
