class AddDiaryIdToSleep < ActiveRecord::Migration[5.1]
  def change
    add_column :sleeps, :diary_id, :integer
    add_index :sleeps, :diary_id
  end
end
