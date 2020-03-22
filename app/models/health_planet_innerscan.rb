# == Schema Information
#
# Table name: health_planet_innerscans
#
#  id                   :bigint(8)        not null, primary key
#  health_planet_id     :integer          not null
#  datetime             :datetime         not null
#  weight               :decimal(5, 2)    not null
#  body_fat_percentage  :decimal(4, 2)
#  muscle_mass          :decimal(4, 2)
#  muscle_score         :integer
#  visceral_fat_level1  :decimal(4, 2)
#  visceral_fat_level2  :decimal(4, 2)
#  basal_metabolic_rate :integer
#  body_age             :integer
#  bone_mass            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_health_planet_innerscans_on_health_planet_id_and_datetime  (health_planet_id,datetime) UNIQUE
#

class HealthPlanetInnerscan < ApplicationRecord
  belongs_to :health_planet
end
