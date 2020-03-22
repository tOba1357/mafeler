module Fitbit
  class ActivitiesController < Fitbit::ApplicationController
    def sync
      @activities = FitbitActivityService.import_activities fitbit_account
      render json: @activities
    end

    def index
      page = params[:page] || 1
      @activities = FitbitActivity.where(fitbit_account: fitbit_account).order(start_time: :DESC).page(page)
      render json: {activities: @activities, page: page, total_page: @activities.total_pages}
    end

    def show
      @activity = fitbit_account.fitbit_activities.find_by!(id: params[:id])
      render json: @activity
    end

  end
end
