module Fitbit
  class WebhookController < ActionController::Base
    # https://dev.fitbit.com/build/reference/web-api/subscriptions/#verify-a-subscriber
    def verify
      if params[:verify] == ENV['FITIBT_VERIFICATION_CODE']
        head 204
      else
        head 404
      end
    end

    def notification
      head 404 unless check_signature?
      # [
      #   {
      #     "collectionType": "foods",
      #     "date": "2010-03-01",
      #     "ownerId": "228S74",
      #     "ownerType": "user",
      #     "subscriptionId": "1234"
      #   }, ... ]
      # TODO: implement
      head 204
    end

    private
    def check_signature?
      # TODO: delete log
      Rails.logger.debug(request.headers['X-Fitbit-Signature'])
      Rails.logger.debug(request.body.read)
      signature = request.headers['X-Fitbit-Signature']
      return false if signature.blank?
      hash = OpenSSL::HMAC.digest('sha1', ENV['FITBIT_CLIENT_SECRET'] + '&', request.body.read)
      hash = Base64.encode64(hash)
      signature == hash
    end
  end
end
