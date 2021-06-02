module Fitbit
  class AuthenticateController < Fitbit::ApplicationController
    skip_before_action :associate_fitbit_account, except: [:subscribe]
    def show
      render json: {
        fitbit_connected: fitbit_account.present?,
        fitbit_subscribed: fitbit_account&.subscribed_at.present?
      }
    end

    def authenticate
      if fitbit_account.blank?
        redirect_to "https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=#{ENV['FITBIT_CLIENT_ID']}&redirect_uri=#{fitbit_callback_url}&scope=activity%20nutrition%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight"
      else
        flash[:alert] = 'すでに連携しています。'
        redirect_back(fallback_location: root_path)
      end
    end


    def callback
      return redirect_to root_path if params[:code].blank?
      if FitbitAuthorizationService.authorization(current_user, params[:code], fitbit_callback_url)
        service = FitbitSubscriptionService.new(current_user.fitbit_account.reload)
        if service.add_subscription
          flash[:notice] = 'Fitbitと連携しました。'
          redirect_back(fallback_location: root_path)
        else
          flash[:alert] = 'Fitbitと連携に失敗しました。'
          redirect_back(fallback_location: root_path)
        end
      else
        flash[:alert] = 'Fitbitと連携に失敗しました。'
        redirect_back(fallback_location: root_path)
      end
    end

    def subscribe
      service = FitbitSubscriptionService.new(fitbit_account)
      if service.add_subscription
        head 204
      else
        render json: service.errors.map(&:message).join("\n"), status: 400
      end
    end
  end
end
