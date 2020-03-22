# == Schema Information
#
# Table name: user_defined_items
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  value_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_defined_items_on_user_id_and_name  (user_id,name) UNIQUE
#

class UserDefinedItem < ApplicationRecord
  belongs_to :user
  has_many :user_defined_item_values, dependent: :delete_all
  # TODO: apply all value
  # enum value_type: [:integer, :string, :degree, :boolean, :time]
  enum value_type: {integer: 'integer'}

  validates :value_type, presence: true
  validates :name, presence: true
end
