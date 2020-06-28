class FitbitSyncWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2, backtrace: true

  def perform(row)
    fitbit_account = FitbitAccount.find_by(id: row['subscriptionId'])
    if fitbit_account.nil?
      Rails.logger.warn("fitbit account not found. body: #{row}")
    end
    target_date = Date.parse(row['date'])
    case row['collectionType']
    when 'activities'
      FitbitHeartRateService.import_heart_rates fitbit_account, target_date, target_date
      # TODO: target date
      FitbitActivityService.import_activities fitbit_account
    when 'sleep'
      FitbitSleepService.import_sleep fitbit_account, target_date, target_date
    end
  end
end