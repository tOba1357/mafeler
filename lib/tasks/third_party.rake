namespace :third_party do
  task sync_all: :environment do
    FitbitAccount.includes(:fitbit_activities, :fitbit_heart_rates, :fitbit_sleeps).all.each do |fitbit_account|
      FitbitSleepService.import_sleep fitbit_account
      FitbitActivityService.import_activities fitbit_account
      FitbitHeartRateService.import_heart_rates fitbit_account
    end

    HealthPlanet.all.each do |health_planet|
      HealthPlanetInnerscanService.import health_planet
    end
  end
end
