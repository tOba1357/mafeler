class HealthPlanet::ApplicationController < ApplicationController
  before_action :associate_health_planet

  private

  def associate_health_planet
    if health_planet.blank?
      render json: 'Settingsから連携してください。', status: 400
    end
  end
end
