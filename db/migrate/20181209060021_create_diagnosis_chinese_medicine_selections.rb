class CreateDiagnosisChineseMedicineSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnosis_chinese_medicine_selections do |t|
      t.integer :chinese_medicine_diagnosis_id, null: false
      t.integer :chinese_medicine_selection_id, null: false

      t.timestamps
    end

    add_index :diagnosis_chinese_medicine_selections, [:chinese_medicine_diagnosis_id, :chinese_medicine_selection_id], unique: true, name: 'uidx_diagnosis_chinese_medicine_selections'
  end
end
