class AddNoteToDiary < ActiveRecord::Migration[5.1]
  def change
    add_column :diaries, :note, :text
  end
end
