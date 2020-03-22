class AddPhysicalTrainingToDiaries < ActiveRecord::Migration[5.1]
  def change
    add_column :diaries, :physical_training, :integer, default: 0
    add_column :diaries, :protein, :integer, default: 0
  end
end
