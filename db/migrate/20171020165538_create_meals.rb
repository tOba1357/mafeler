class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    remove_column :diaries, :eat_breakfast_time, :integer
    remove_column :diaries, :eat_lunch_time, :integer
    remove_column :diaries, :eat_diner_time, :integer
    create_table :meals do |t|
      t.integer :user_id, null: false
      t.string :name
      t.datetime :eat_at, null: false

      t.timestamps
    end
    add_index :meals, [:user_id, :eat_at]
  end
end
