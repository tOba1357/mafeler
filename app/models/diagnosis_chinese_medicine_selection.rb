# == Schema Information
#
# Table name: diagnosis_chinese_medicine_selections
#
#  id                            :bigint(8)        not null, primary key
#  chinese_medicine_diagnosis_id :integer          not null
#  chinese_medicine_selection_id :integer          not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  uidx_diagnosis_chinese_medicine_selections  (chinese_medicine_diagnosis_id,chinese_medicine_selection_id) UNIQUE
#

class DiagnosisChineseMedicineSelection < ApplicationRecord
  belongs_to :chinese_medicine_diagnosis
  belongs_to :chinese_medicine_selection
end
