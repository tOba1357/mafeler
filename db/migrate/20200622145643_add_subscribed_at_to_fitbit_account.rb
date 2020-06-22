class AddSubscribedAtToFitbitAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :fitbit_accounts, :subscribed_at, :datetime
  end
end
