# == Schema Information
#
# Table name: illuminations
#
#  id             :bigint(8)        not null, primary key
#  nature_remo_id :integer          not null
#  value          :float            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_illuminations_on_nature_remo_id_and_created_at  (nature_remo_id,created_at) UNIQUE
#

class Illumination < ApplicationRecord
  belongs_to :nature_remo
end
