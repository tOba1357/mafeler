class CreateUserDefinedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :user_defined_items do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :value_type, null: false

      t.timestamps
    end
    add_index :user_defined_items, [:user_id, :name], unique: true
  end
end
