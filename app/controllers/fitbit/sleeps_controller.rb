module Fitbit
  class SleepsController < Fitbit::ApplicationController
    def sync
      @sleeps = FitbitSleepService.import_sleep fitbit_account
      render json: @sleeps
    end

    def index
      page = params[:page] || 1
      @sleeps = FitbitSleep.where(fitbit_account: fitbit_account).order(start_time: :DESC).page(page)
      render json: {sleeps: @sleeps, page: page, total_page: @sleeps.total_pages}
    end

    def show
      @sleep = fitbit_account.fitbit_sleeps.find_by!(id: params[:id])
      render json: @sleep
    end
  end
end
