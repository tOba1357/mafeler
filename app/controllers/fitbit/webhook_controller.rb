module Fitbit
  class WebhookController < Fitbit::ApplicationController
    skip_before_action :associate_fitbit_account
    # https://dev.fitbit.com/build/reference/web-api/subscriptions/#verify-a-subscriber
    def index
      if params[:verify] == ENV['FITIBT_VERIFICATION_CODE']
        head 204
      else
        head 404
      end
    end
  end
end
