class CreateHealthPlanets < ActiveRecord::Migration[5.2]
  def change
    create_table :health_planets do |t|
      t.integer :user_id, null: false
      t.text :refresh_token, null: false

      t.timestamps
    end

    add_index :health_planets, :user_id, unique: true
  end
end
