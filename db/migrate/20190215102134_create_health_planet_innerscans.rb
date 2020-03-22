class CreateHealthPlanetInnerscans < ActiveRecord::Migration[5.2]
  def change
    create_table :health_planet_innerscans do |t|
      t.integer :health_planet_id, null: false
      t.datetime :datetime, null: false

      t.decimal :weight, precision: 5, scale: 2, null: false
      t.decimal :body_fat_percentage, precision: 4, scale: 2
      t.decimal :muscle_mass, precision: 4, scale: 2
      t.integer :muscle_score
      t.decimal :visceral_fat_level1, precision: 4, scale: 2
      t.decimal :visceral_fat_level2, precision: 4, scale: 2
      t.integer :basal_metabolic_rate
      t.integer :body_age
      t.integer :bone_mass, precision: 4, scale: 2

      t.timestamps
    end

    add_index :health_planet_innerscans, [:health_planet_id, :datetime], unique: true
  end
end
