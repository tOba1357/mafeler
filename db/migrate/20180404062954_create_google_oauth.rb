class CreateGoogleOauth < ActiveRecord::Migration[5.1]
  def change
    create_table :google_oauths do |t|
      t.integer :user_id, null: false
      t.string :refresh_token, null: false
      t.string :uid, null: false
    end
    add_index :google_oauths, :user_id
  end
end
