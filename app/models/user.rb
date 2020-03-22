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

class User < ApplicationRecord
  has_one :fitbit_account, dependent: :destroy
  has_one :google_oauth, dependent: :delete
  has_one :nature_remo, dependent: :destroy
  has_one :health_planet, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :sleeps, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :chinese_medicine_diagnoses, dependent: :destroy

  has_many :user_defined_items, dependent: :destroy

  enum gender: {female: 'female', male: 'male'}
  validates :gender, :birthday, :height, :weight, presence: true, on: :profile

  def diaries_warning
    yesterday = Time.zone.now.to_date - 1.day
    return '' if latest_diary.nil?
    return 'diaryが未入力です。入力しましょう！' if latest_diary.date < yesterday
    ''
  end

  def latest_diary
    @latest_diary ||= diaries.order(:date).last
  end

  # FIXME
  def admin?
    if Rails.env.development?
      return true
    end
    id == 1
  end

  def as_json(options={})
    options[:except] = [:id, :created_at, :updated_at]
    super(options)
  end
end
