# == Schema Information
#
# Table name: google_oauths
#
#  id            :bigint(8)        not null, primary key
#  user_id       :integer          not null
#  refresh_token :string           not null
#  uid           :string           not null
#
# Indexes
#
#  index_google_oauths_on_uid      (uid)
#  index_google_oauths_on_user_id  (user_id)
#

class GoogleOauth < ApplicationRecord
  belongs_to :user
end
