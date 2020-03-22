class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.integer :nature_remo_id, null: false
      t.float :value, null: false
      t.timestamps
    end
    add_index :temperatures, [:nature_remo_id, :created_at], unique: true
  end
end
