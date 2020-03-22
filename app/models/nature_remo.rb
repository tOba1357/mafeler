# == Schema Information
#
# Table name: nature_remos
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer          not null
#  access_token :string           not null
#  uid          :string           not null
#  nickname     :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_nature_remos_on_user_id  (user_id) UNIQUE
#

class NatureRemo < ApplicationRecord
  belongs_to :user
  has_many :humidities, dependent: :delete_all
  has_many :illuminations, dependent: :delete_all
  has_many :temperatures, dependent: :delete_all
end
