module Fitbit
  class WebhookController < ActionController::Base
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
