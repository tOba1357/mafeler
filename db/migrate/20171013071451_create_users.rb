class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, nulL: false
      t.integer :status, null: false, default: 1
      t.string :confirm_token
      t.datetime :confirmed_at
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
