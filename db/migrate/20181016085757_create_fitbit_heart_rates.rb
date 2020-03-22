class CreateFitbitHeartRates < ActiveRecord::Migration[5.1]
  def change
    create_table :fitbit_heart_rates do |t|
      t.integer :fitbit_account_id, null: false
      t.date :date, null: false

      t.integer :out_of_range_minutes, null: false
      t.integer :fat_burn_minutes, null: false
      t.integer :cardio_minutes, null: false
      t.integer :peak_minutes, null: false

      t.float :out_of_range_calories_out, null: false
      t.float :fat_burn_calories_out, null: false
      t.float :cardio_calories_out, null: false
      t.float :peak_calories_out, null: false

      t.integer :resting_heart_rate
      t.timestamps
    end
    add_index :fitbit_heart_rates, [:fitbit_account_id, :date], unique: true
  end
end
