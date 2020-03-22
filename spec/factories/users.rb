# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gender     :string
#  birthday   :date
#  height     :integer
#  weight     :float
#

FactoryBot.define do
  factory :user do
  end
end
