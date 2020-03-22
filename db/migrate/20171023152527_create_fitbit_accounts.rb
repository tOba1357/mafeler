class CreateFitbitAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :fitbit_accounts do |t|
      t.integer :user_id, null: false
      t.text :refresh_token, null: false
      t.string :fitbit_user_id, null: false

      t.timestamps
    end
    add_index :fitbit_accounts, :user_id
  end
end
