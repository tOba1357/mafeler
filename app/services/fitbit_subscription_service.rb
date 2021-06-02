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
    case res.code
    when 200
      fitbit_account.update!(subscribed_at: Time.zone.now)
      return true
    when 201
      # do nothing
      return true
    else
      e = Exception.new('fitbit subscription failed')
      Rollbar.error(e, res)
      # define as class
      errors.push(OpenStruct.new(message: 'subscription failed', response: res))
      return false
    end
  end
end
