# == Schema Information
#
# Table name: diaries
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  date       :date             not null
#  nap_hour   :integer
#  appetite   :integer
#  motivation :integer
#  condition  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note       :text
#
# Indexes
#
#  index_diaries_on_user_id_and_date  (user_id,date) UNIQUE
#

class Diary < ApplicationRecord
  belongs_to :user
  has_many :sleeps
  has_many :user_defined_item_values
  alias :udivs :user_defined_item_values

  accepts_nested_attributes_for :sleeps, allow_destroy: true

  def self.ENUM_DEGREE
    %w[good so_so bad]
  end

  enum appetite: Diary.ENUM_DEGREE, _prefix: true
  enum motivation: Diary.ENUM_DEGREE, _prefix: true
  enum condition: Diary.ENUM_DEGREE, _prefix: true

  validates :date, presence: true
  validate :has_same_date

  def to_param
    date.to_s
  end

  def to_form_hash
    as_json(include: [:sleeps, :user_defined_item_values])
  end

  private
  def has_same_date
    errors.add(:base, 'すでにDiaryが存在します。') if user.diaries.where.not(id: id).where(date: date).present?
  end
end
