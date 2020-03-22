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

require 'rails_helper'

describe User do
  let (:user) {create(:user)}
  describe '#diaries_warning' do
    it 'no diary' do
      expect(user.diaries_warning).to be_blank
    end
     it 'has diary' do
       create(:diary, user: user, date: Time.zone.now.to_date - 3.day)
       expect(user.diaries_warning).to be_present
     end
  end

  describe '#latest_diary' do
    it 'no diary and return nil' do
      latest_diary = user.latest_diary
      expect(latest_diary).to be_blank
    end

    it 'return latest diary' do
      today = Time.zone.now.to_date
      yesterday = today - 1.day
      today_diary = create(:diary, user: user, date: today)
      yesterday_diary = create(:diary, user: user, date: yesterday)
      latest_diary = user.latest_diary
      expect(latest_diary).to eq(today_diary)
    end
  end
end
