class CreateFitbitActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :fitbit_activities do |t|
      t.integer :fitbit_account_id, null: false
      t.datetime :start_time, null: false

      t.integer :log_id, limit: 8, null: false

      t.integer :activity_type_id, null: false
      t.string :activity_name, null: false

      # activityLevel
      t.integer :sedentary_minutes, null: false
      t.integer :lightly_minutes, null: false
      t.integer :fairly_minutes, null: false
      t.integer :very_minutes, null: false

      # heartRateZones
      t.integer :out_of_range_minutes
      t.integer :fat_burn_minutes
      t.integer :cardio_minutes
      t.integer :peak_minutes

      t.integer :average_heart_rate

      t.integer :active_duration, limit: 8, null: false
      t.integer :duration, limit: 8, null: false
      t.integer :calories, null: false
      t.integer :steps, null: false

      t.timestamps
    end
    add_index :fitbit_activities, [:fitbit_account_id, :start_time]
    add_index :fitbit_activities, [:fitbit_account_id, :activity_type_id], name: 'index_fitbit_activities_type_id'
    add_index :fitbit_activities, [:log_id], unique: true
  end
end
