class CreateSleeps < ActiveRecord::Migration[5.1]
  def change
    create_table :sleeps do |t|
      t.integer :user_id, null: false
      t.datetime :slept_at, null: false
      t.datetime :woke_up_at, null: false

      t.timestamps
    end
    add_index :sleeps, [:user_id, :woke_up_at]
  end
end
