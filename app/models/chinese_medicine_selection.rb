# == Schema Information
#
# Table name: chinese_medicine_selections
#
#  id                               :bigint(8)        not null, primary key
#  chinese_medicine_constitution_id :integer          not null
#  label                            :string           not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
# Indexes
#
#  idx_chinese_medicine_selections_constitution_id  (chinese_medicine_constitution_id)
#

class ChineseMedicineSelection < ApplicationRecord
  has_many :diagnosis_chinese_medicine_selections
  has_many :chinese_medicine_diagnoses, through: :diagnosis_chinese_medicine_selections
  belongs_to :chinese_medicine_constitution

  TARGET_CONSTITUTIONS = %i(blood blood_stasis humor stagnation water_stagnation haphazard)
  enum target_constitution: TARGET_CONSTITUTIONS.map{|v| [v, v.to_s]}.to_h
  validates :label, presence: true
end
