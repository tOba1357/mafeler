# == Schema Information
#
# Table name: fitbit_heart_rates
#
#  id                        :bigint(8)        not null, primary key
#  fitbit_account_id         :integer          not null
#  date                      :date             not null
#  out_of_range_minutes      :integer          not null
#  fat_burn_minutes          :integer          not null
#  cardio_minutes            :integer          not null
#  peak_minutes              :integer          not null
#  out_of_range_calories_out :float            not null
#  fat_burn_calories_out     :float            not null
#  cardio_calories_out       :float            not null
#  peak_calories_out         :float            not null
#  resting_heart_rate        :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_fitbit_heart_rates_on_fitbit_account_id_and_date  (fitbit_account_id,date) UNIQUE
#

class FitbitHeartRate < ApplicationRecord
  belongs_to :fitbit_account
end
