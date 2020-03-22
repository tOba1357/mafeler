# == Schema Information
#
# Table name: meals
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  name       :string
#  eat_at     :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_meals_on_user_id_and_eat_at  (user_id,eat_at)
#

class Meal < ApplicationRecord
  belongs_to :user
  validates :name, :eat_at, presence: true
end
