# == Schema Information
#
# Table name: sleeps
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  slept_at   :datetime         not null
#  woke_up_at :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diary_id   :integer
#
# Indexes
#
#  index_sleeps_on_diary_id                (diary_id)
#  index_sleeps_on_user_id_and_woke_up_at  (user_id,woke_up_at)
#

class Sleep < ApplicationRecord
  belongs_to :user
  belongs_to :diary, optional: true
  validates :slept_at, :woke_up_at, presence: true
  validate :bigger_woke_up_at_than_slept_at

  private
  def bigger_woke_up_at_than_slept_at
    if slept_at >= woke_up_at
      errors.add(:base, '寝た時刻より起きた時刻の方が早いです。')
    end
  end
end
