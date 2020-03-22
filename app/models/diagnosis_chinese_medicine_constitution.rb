# == Schema Information
#
# Table name: diagnosis_chinese_medicine_constitutions
#
#  id                               :bigint(8)        not null, primary key
#  chinese_medicine_diagnosis_id    :integer          not null
#  chinese_medicine_constitution_id :integer          not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
# Indexes
#
#  uidx_diagnosis_chinese_medicine_constitutions  (chinese_medicine_diagnosis_id,chinese_medicine_constitution_id) UNIQUE
#

class DiagnosisChineseMedicineConstitution < ApplicationRecord
  belongs_to :chinese_medicine_diagnosis
  belongs_to :chinese_medicine_constitution
end
