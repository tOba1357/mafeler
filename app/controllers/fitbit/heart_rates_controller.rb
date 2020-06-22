module Fitbit
  class HeartRatesController < Fitbit::ApplicationController
    def sync
      @heart_rates = FitbitHeartRateService.import_heart_rates fitbit_account
      render json: @heart_rates
    end

    def index
      page = params[:page] || 1
      @heart_rates = FitbitHeartRate.where(fitbit_account: fitbit_account).order(date: :DESC).page(page)
      render json: {heart_rates: @heart_rates, page: page, total_page: @heart_rates.total_pages}
    end

    def show
      @heart_rate = fitbit_account.fitbit_heart_rates.find_by!(id: params[:id])
      render json: @heart_rate
    end
  end
end
