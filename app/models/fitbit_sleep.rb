# == Schema Information
#
# Table name: fitbit_sleeps
#
#  id                   :bigint(8)        not null, primary key
#  fitbit_account_id    :integer          not null
#  date                 :date             not null
#  log_id               :bigint(8)        not null
#  start_time           :datetime         not null
#  end_time             :datetime         not null
#  efficiency           :integer
#  minutes_after_wakeup :integer
#  minutes_asleep       :integer
#  minutes_awake        :integer
#  deep_count           :integer
#  deep_minutes         :integer
#  light_count          :integer
#  light_minutes        :integer
#  rem_count            :integer
#  rem_minutes          :integer
#  wake_count           :integer
#  wake_minutes         :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_fitbit_sleeps_on_fitbit_account_id_and_date  (fitbit_account_id,date)
#  index_fitbit_sleeps_on_log_id                      (log_id) UNIQUE
#

class FitbitSleep < ApplicationRecord
  belongs_to :fitbit_account
end
