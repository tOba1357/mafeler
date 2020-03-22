# == Schema Information
#
# Table name: chinese_medicine_diagnoses
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chinese_medicine_diagnoses_on_user_id_and_created_at  (user_id,created_at)
#

class ChineseMedicineDiagnosis < ApplicationRecord
  belongs_to :user

  has_many :diagnosis_chinese_medicine_constitutions, dependent: :delete_all
  has_many :chinese_medicine_constitutions, through: :diagnosis_chinese_medicine_constitutions
  has_many :diagnosis_chinese_medicine_selections, dependent: :delete_all
  has_many :chinese_medicine_selections, through: :diagnosis_chinese_medicine_selections
end
