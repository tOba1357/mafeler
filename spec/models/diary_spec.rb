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

require 'rails_helper'

describe Diary do
  let (:user) {create(:user)}

end
