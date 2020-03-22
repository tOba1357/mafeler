# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_25_075813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chinese_medicine_constitutions", force: :cascade do |t|
    t.string "label", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chinese_medicine_diagnoses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_chinese_medicine_diagnoses_on_user_id_and_created_at"
  end

  create_table "chinese_medicine_selections", force: :cascade do |t|
    t.integer "chinese_medicine_constitution_id", null: false
    t.string "label", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chinese_medicine_constitution_id"], name: "idx_chinese_medicine_selections_constitution_id"
  end

  create_table "diagnosis_chinese_medicine_constitutions", force: :cascade do |t|
    t.integer "chinese_medicine_diagnosis_id", null: false
    t.integer "chinese_medicine_constitution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chinese_medicine_diagnosis_id", "chinese_medicine_constitution_id"], name: "uidx_diagnosis_chinese_medicine_constitutions", unique: true
  end

  create_table "diagnosis_chinese_medicine_selections", force: :cascade do |t|
    t.integer "chinese_medicine_diagnosis_id", null: false
    t.integer "chinese_medicine_selection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chinese_medicine_diagnosis_id", "chinese_medicine_selection_id"], name: "uidx_diagnosis_chinese_medicine_selections", unique: true
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "date", null: false
    t.integer "nap_hour"
    t.integer "appetite"
    t.integer "motivation"
    t.integer "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.index ["user_id", "date"], name: "index_diaries_on_user_id_and_date", unique: true
  end

  create_table "fitbit_accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "refresh_token", null: false
    t.string "fitbit_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fitbit_accounts_on_user_id"
  end

  create_table "fitbit_activities", force: :cascade do |t|
    t.integer "fitbit_account_id", null: false
    t.datetime "start_time", null: false
    t.bigint "log_id", null: false
    t.integer "activity_type_id", null: false
    t.string "activity_name", null: false
    t.integer "sedentary_minutes", null: false
    t.integer "lightly_minutes", null: false
    t.integer "fairly_minutes", null: false
    t.integer "very_minutes", null: false
    t.integer "out_of_range_minutes"
    t.integer "fat_burn_minutes"
    t.integer "cardio_minutes"
    t.integer "peak_minutes"
    t.integer "average_heart_rate"
    t.bigint "active_duration", null: false
    t.bigint "duration", null: false
    t.integer "calories", null: false
    t.integer "steps", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fitbit_account_id", "activity_type_id"], name: "index_fitbit_activities_type_id"
    t.index ["fitbit_account_id", "start_time"], name: "index_fitbit_activities_on_fitbit_account_id_and_start_time"
    t.index ["log_id"], name: "index_fitbit_activities_on_log_id", unique: true
  end

  create_table "fitbit_heart_rates", force: :cascade do |t|
    t.integer "fitbit_account_id", null: false
    t.date "date", null: false
    t.integer "out_of_range_minutes", null: false
    t.integer "fat_burn_minutes", null: false
    t.integer "cardio_minutes", null: false
    t.integer "peak_minutes", null: false
    t.float "out_of_range_calories_out", null: false
    t.float "fat_burn_calories_out", null: false
    t.float "cardio_calories_out", null: false
    t.float "peak_calories_out", null: false
    t.integer "resting_heart_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fitbit_account_id", "date"], name: "index_fitbit_heart_rates_on_fitbit_account_id_and_date", unique: true
  end

  create_table "fitbit_sleeps", force: :cascade do |t|
    t.integer "fitbit_account_id", null: false
    t.date "date", null: false
    t.bigint "log_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "efficiency"
    t.integer "minutes_after_wakeup"
    t.integer "minutes_asleep"
    t.integer "minutes_awake"
    t.integer "deep_count"
    t.integer "deep_minutes"
    t.integer "light_count"
    t.integer "light_minutes"
    t.integer "rem_count"
    t.integer "rem_minutes"
    t.integer "wake_count"
    t.integer "wake_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fitbit_account_id", "date"], name: "index_fitbit_sleeps_on_fitbit_account_id_and_date"
    t.index ["log_id"], name: "index_fitbit_sleeps_on_log_id", unique: true
  end

  create_table "google_oauths", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "refresh_token", null: false
    t.string "uid", null: false
    t.index ["uid"], name: "index_google_oauths_on_uid"
    t.index ["user_id"], name: "index_google_oauths_on_user_id"
  end

  create_table "health_planet_innerscans", force: :cascade do |t|
    t.integer "health_planet_id", null: false
    t.datetime "datetime", null: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.decimal "body_fat_percentage", precision: 4, scale: 2
    t.decimal "muscle_mass", precision: 4, scale: 2
    t.integer "muscle_score"
    t.decimal "visceral_fat_level1", precision: 4, scale: 2
    t.decimal "visceral_fat_level2", precision: 4, scale: 2
    t.integer "basal_metabolic_rate"
    t.integer "body_age"
    t.integer "bone_mass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_planet_id", "datetime"], name: "index_health_planet_innerscans_on_health_planet_id_and_datetime", unique: true
  end

  create_table "health_planets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "refresh_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_health_planets_on_user_id", unique: true
  end

  create_table "humidities", force: :cascade do |t|
    t.integer "nature_remo_id", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nature_remo_id", "created_at"], name: "index_humidities_on_nature_remo_id_and_created_at", unique: true
  end

  create_table "illuminations", force: :cascade do |t|
    t.integer "nature_remo_id", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nature_remo_id", "created_at"], name: "index_illuminations_on_nature_remo_id_and_created_at", unique: true
  end

  create_table "meals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.datetime "eat_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "eat_at"], name: "index_meals_on_user_id_and_eat_at"
  end

  create_table "nature_remos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "access_token", null: false
    t.string "uid", null: false
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nature_remos_on_user_id", unique: true
  end

  create_table "sleeps", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "slept_at", null: false
    t.datetime "woke_up_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "diary_id"
    t.index ["diary_id"], name: "index_sleeps_on_diary_id"
    t.index ["user_id", "woke_up_at"], name: "index_sleeps_on_user_id_and_woke_up_at"
  end

  create_table "temperatures", force: :cascade do |t|
    t.integer "nature_remo_id", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nature_remo_id", "created_at"], name: "index_temperatures_on_nature_remo_id_and_created_at", unique: true
  end

  create_table "user_defined_item_values", force: :cascade do |t|
    t.integer "user_defined_item_id", null: false
    t.integer "diary_id", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_user_defined_item_values_on_diary_id"
    t.index ["user_defined_item_id", "diary_id"], name: "unique_index_user_defined_item_values", unique: true
  end

  create_table "user_defined_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "value_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_user_defined_items_on_user_id_and_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.date "birthday"
    t.integer "height"
    t.float "weight"
  end

end
