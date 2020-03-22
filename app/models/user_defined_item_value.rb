# == Schema Information
#
# Table name: user_defined_item_values
#
#  id                   :bigint(8)        not null, primary key
#  user_defined_item_id :integer          not null
#  diary_id             :integer          not null
#  value                :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_user_defined_item_values_on_diary_id  (diary_id)
#  unique_index_user_defined_item_values       (user_defined_item_id,diary_id) UNIQUE
#

class UserDefinedItemValue < ApplicationRecord
  belongs_to :user_defined_item
  belongs_to :diary
end
