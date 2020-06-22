# == Schema Information
#
# Table name: fitbit_accounts
#
#  id             :bigint(8)        not null, primary key
#  user_id        :integer          not null
#  refresh_token  :text             not null
#  fitbit_user_id :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_fitbit_accounts_on_user_id  (user_id)
#

class FitbitAccount < ApplicationRecord
  belongs_to :user
  has_many :fitbit_sleeps, dependent: :delete_all
  has_many :fitbit_activities, dependent: :delete_all
  has_many :fitbit_heart_rates, dependent: :delete_all

  def subscription_id
    id
  end
end
