class CreateChineseMedicineDiagnoses < ActiveRecord::Migration[5.2]
  def change
    create_table :chinese_medicine_diagnoses do |t|
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :chinese_medicine_diagnoses, [:user_id, :created_at]
  end
end
