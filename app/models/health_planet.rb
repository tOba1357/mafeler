# == Schema Information
#
# Table name: health_planets
#
#  id            :bigint(8)        not null, primary key
#  user_id       :integer          not null
#  refresh_token :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_health_planets_on_user_id  (user_id) UNIQUE
#

class HealthPlanet < ApplicationRecord
  has_many :health_planet_innerscans, dependent: :delete_all
  alias :innerscans :health_planet_innerscans
end
