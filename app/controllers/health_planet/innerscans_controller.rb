class HealthPlanet::InnerscansController < HealthPlanet::ApplicationController
  def sync
    @innerscans = HealthPlanetInnerscanService.import health_planet
    render json: @heart_rates
  end

  def index
    page = params[:page] || 1
    @innerscans = HealthPlanetInnerscan.where(health_planet: health_planet).order(datetime: :DESC).page(page)
    render json: {innerscans: @innerscans, page: page, total_page: @innerscans.total_pages}
  end

  def show
    @innerscan = health_planet.innerscans.find_by!(id: params[:id])
    render json: @innerscan
  end
end
