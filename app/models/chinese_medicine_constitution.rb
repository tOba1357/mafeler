# == Schema Information
#
# Table name: chinese_medicine_constitutions
#
#  id         :bigint(8)        not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChineseMedicineConstitution < ApplicationRecord
  has_many :diagnosis_chinese_medicine_constitutions
  has_many :chinese_medicine_diagnoses, through: :diagnosis_chinese_medicine_constitutions
  has_many :chinese_medicine_selections
end
