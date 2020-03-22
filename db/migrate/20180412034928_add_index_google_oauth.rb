class AddIndexGoogleOauth < ActiveRecord::Migration[5.1]
  def change
    add_index :google_oauths, :uid
  end
end
