# == Schema Information
#
# Table name: fitbit_activities
#
#  id                   :bigint(8)        not null, primary key
#  fitbit_account_id    :integer          not null
#  start_time           :datetime         not null
#  log_id               :bigint(8)        not null
#  activity_type_id     :integer          not null
#  activity_name        :string           not null
#  sedentary_minutes    :integer          not null
#  lightly_minutes      :integer          not null
#  fairly_minutes       :integer          not null
#  very_minutes         :integer          not null
#  out_of_range_minutes :integer
#  fat_burn_minutes     :integer
#  cardio_minutes       :integer
#  peak_minutes         :integer
#  average_heart_rate   :integer
#  active_duration      :bigint(8)        not null
#  duration             :bigint(8)        not null
#  calories             :integer          not null
#  steps                :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_fitbit_activities_on_fitbit_account_id_and_start_time  (fitbit_account_id,start_time)
#  index_fitbit_activities_on_log_id                            (log_id) UNIQUE
#  index_fitbit_activities_type_id                              (fitbit_account_id,activity_type_id)
#

class FitbitActivity < ApplicationRecord
  belongs_to :fitbit_account

end
