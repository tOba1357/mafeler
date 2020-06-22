class FitbitSubscriptionService
  attr_accessor :fitbit_account, :errors
  def initialize(fitbit_account)
    @fitbit_account = fitbit_account
    @errors = []
  end

  def add_subscription
    access_token = FitbitService.get_access_token fitbit_account
    url = URI.parse("https://api.fitbit.com/1/user/#{fitbit_account.fitbit_user_id}/apiSubscriptions/#{fitbit_account.subscription_id}.json")
    req = Net::HTTP::Post.new(url.to_s)
    req['Authorization'] = "Bearer #{access_token}"
    res = Net::HTTP.start(url.host, use_ssl: true) {|http| http.request(req)}
    case res
    when Net::HTTPSuccess
      case res.code
      when 200
        fitbit_account.update!(subscribed_at: Time.zone.now)
      when 201
        # do nothing
      else
        Rails.logger.warn("unknown fitbit subscription response code. code: #{res.code}, body: #{res.body}")
      end
      return true
    else
      # define as class
      errors.push(OpenStruct(message: 'subscription failed', response: res))
      return false
    end
  end
end
