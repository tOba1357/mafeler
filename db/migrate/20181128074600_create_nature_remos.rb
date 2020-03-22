class CreateNatureRemos < ActiveRecord::Migration[5.2]
  def change
    create_table :nature_remos do |t|
      t.integer :user_id, null: false
      t.string :access_token, null: false
      t.string :uid, null: false
      t.string :nickname, null: false
      t.timestamps
    end
    add_index :nature_remos, :user_id, unique: true
  end
end
