class CreateDiagnosisChineseMedicineConstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnosis_chinese_medicine_constitutions do |t|
      t.integer :chinese_medicine_diagnosis_id, null: false
      t.integer :chinese_medicine_constitution_id, null: false
      t.timestamps
    end

    add_index :diagnosis_chinese_medicine_constitutions, [:chinese_medicine_diagnosis_id, :chinese_medicine_constitution_id], unique: true, name: 'uidx_diagnosis_chinese_medicine_constitutions'
  end
end
