namespace :third_party do
  task sync_all: :environment do
    Rake::Task['third_party:sync_fitbit'].invoke
    Rake::Task['third_party:sync_health_planet'].invoke
  end

  task sync_fitbit: :environment do
    FitbitAccount.includes(:fitbit_activities, :fitbit_heart_rates, :fitbit_sleeps).all.each do |fitbit_account|
      begin
        FitbitSleepService.import_sleep fitbit_account
        FitbitActivityService.import_activities fitbit_account
        FitbitHeartRateService.import_heart_rates fitbit_account
      rescue => e
        Rails.logger.error("sync fitbit failed. fitbit_account_id: #{fitbit_account.id}")
        Rails.logger.error("#{e.message}\n#{e.backtrace}")
      end
    end
  end

  task sync_health_planet: :environment do
    HealthPlanet.all.each do |health_planet|
      begin
        HealthPlanetInnerscanService.import health_planet
      rescue => e
        Rails.logger.error("sync health planet failed. health_planet_id: #{health_planet.id}")
        Rails.logger.error("#{e.message}\n#{e.backtrace}")
      end
    end
  end
end
