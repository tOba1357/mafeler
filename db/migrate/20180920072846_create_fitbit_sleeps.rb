class CreateFitbitSleeps < ActiveRecord::Migration[5.1]
  def change
    create_table :fitbit_sleeps do |t|
      t.integer :fitbit_account_id, null: false
      t.date :date, null: false
      t.integer :log_id, null: false, limit: 8
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.integer :efficiency
      t.integer :minutes_after_wakeup
      t.integer :minutes_asleep
      t.integer :minutes_awake

      t.integer :deep_count
      t.integer :deep_minutes

      t.integer :light_count
      t.integer :light_minutes

      t.integer :rem_count
      t.integer :rem_minutes

      t.integer :wake_count
      t.integer :wake_minutes

      t.timestamps
    end
    add_index :fitbit_sleeps, [:fitbit_account_id, :date]
    add_index :fitbit_sleeps, :log_id, unique: true
  end
end
