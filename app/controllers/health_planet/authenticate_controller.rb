class HealthPlanet::AuthenticateController < ApplicationController
  def show
    render json: current_user.health_planet.present?
  end

  def authenticate
    if current_user.health_planet.nil?
      redirect_to "https://www.healthplanet.jp/oauth/auth?client_id=#{ENV['HEALTH_PLANET_CLIENT_ID']}&redirect_uri=#{redirect_url}&scope=innerscan&response_type=code"
    else
      flash[:alert] = 'すでに連携しています。'
      redirect_back(fallback_location: root_path)
    end
  end

  def callback
    return redirect_to root_path if params[:code].blank?
    if HealthPlanetService.authorization(current_user, params[:code], redirect_url)
      flash[:notice] = 'HealthPlanetと連携しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'HealthPlanetと連携に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def redirect_url
    # localhostを登録できなかったので本番以外ではテスト用APIを使う
    if Rails.env.production?
      health_planet_callback_url
    else
      'https://www.healthplanet.jp/success.html'
    end
  end
end
