class CreateUserDefinedItemValues < ActiveRecord::Migration[5.2]
  def change
    create_table :user_defined_item_values do |t|
      t.integer :user_defined_item_id, null: false
      t.integer :diary_id, null: false
      t.text :value

      t.timestamps
    end
    add_index :user_defined_item_values, [:user_defined_item_id, :diary_id], unique: true, name: 'unique_index_user_defined_item_values'
    add_index :user_defined_item_values, :diary_id
  end
end
