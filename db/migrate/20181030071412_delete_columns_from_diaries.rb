class DeleteColumnsFromDiaries < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |user|
      physical_training_udi = user.user_defined_items.build(name: '筋トレ', value_type: :integer)
      physical_training_udi.save!
      udivs = user.diaries.map do |diary|
        diary.udivs.build(user_defined_item: physical_training_udi, value: diary.physical_training)
      end
      UserDefinedItemValue.import udivs
    end
    remove_column :diaries, :physical_training
    remove_column :diaries, :protein
  end
end
