namespace :nature_remo do
  desc 'sync'
  task sync: :environment do
    NatureRemo.all.each do |nature_remo|
      begin
        NatureRemoService.save_sensor_values nature_remo
      rescue => e
        # TODO: error handling
      end
    end
  end
end
