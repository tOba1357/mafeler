class RemoveEmailAndPassword < ActiveRecord::Migration[5.1]
  def up
    columns = [:email, :password_digest, :confirmed_at, :confirm_token, :status, :name]
    columns.each {|column| remove_column :users, column}
  end
  
  def down
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    add_column :users, :confirmed_at, :time
    add_column :users, :confirm_token, :string
    add_column :users, :status, :integer
    add_column :users, :name, :string
  end
end
