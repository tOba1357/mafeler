module Fitbit
  class WebhookController < ActionController::Base
    protect_from_forgery with: :null_session

    # https://dev.fitbit.com/build/reference/web-api/subscriptions/#verify-a-subscriber
    def verify
      if params[:verify] == ENV['FITIBT_VERIFICATION_CODE']
        head 204
      else
        head 404
      end
    end

    def notification
      return head 404 unless check_signature?
      # [
      #   {
      #     "collectionType": "foods",
      #     "date": "2010-03-01",
      #     "ownerId": "228S74",
      #     "ownerType": "user",
      #     "subscriptionId": "1234"
      #   }, ... ]
      begin
        body = JSON.parse(request.body.read)
        body.each do |row|
          fitbit_account = FitbitAccount.find_by(id: row['subscriptionId'])
          if fitbit_account.nil?
            Rails.logger.warn("fitbit account not found. body: #{row}")
            next
          end
          target_date = Date.parse(row['date'])
          case body['collectionType']
          when 'activities'
            FitbitHeartRateService.import_heart_rates fitbit_account, target_date, target_date
            # TODO: target date
            FitbitActivityService.import_activities fitbit_account
          when 'sleep'
            FitbitSleepService.import_sleep fitbit_account, target_date, target_date
          end
        end
      rescue => e
        Rails.logger.error(e)
        Rails.logger.error(request.body.read)
      ensure
        head 204
      end
    end

    private
    def check_signature?
      signature = request.headers['X-Fitbit-Signature']
      return false if signature.blank?
      hash = OpenSSL::HMAC.digest('sha1', ENV['FITBIT_CLIENT_SECRET'] + '&', request.body.read)
      hash = Base64.strict_encode64(hash)
      if signature != hash
        Rails.logger.warn("not correct signature. signature: #{signature}, body: #{request.body.read}")
      end
      signature == hash
    end
  end
end
