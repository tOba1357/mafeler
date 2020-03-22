class CreateChineseMedicineSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :chinese_medicine_selections do |t|
      t.integer :chinese_medicine_constitution_id, null: false
      t.string :label, null: false

      t.timestamps
    end
    add_index :chinese_medicine_selections, :chinese_medicine_constitution_id, name: 'idx_chinese_medicine_selections_constitution_id'
  end
end
