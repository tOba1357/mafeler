class CreateChineseMedicineConstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :chinese_medicine_constitutions do |t|
      t.string :label, null: false
      t.timestamps
    end
  end
end
