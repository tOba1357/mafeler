class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.integer :eat_breakfast_time
      t.integer :eat_lunch_time
      t.integer :eat_diner_time
      t.integer :nap_hour
      t.integer :appetite
      t.integer :motivation
      t.integer :condition
      t.integer :slept_time
      t.integer :wakeup_time

      t.timestamps
    end

    add_index :diaries, [:user_id, :date], unique: true
  end
end
