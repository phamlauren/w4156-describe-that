# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_13_055109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "description_tracks", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "track_author_id", null: false
    t.string "lang", limit: 2, default: "en", null: false
    t.boolean "is_generated", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["track_author_id"], name: "index_description_tracks_on_track_author_id"
    t.index ["video_id"], name: "index_description_tracks_on_video_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.bigint "desc_track_id", null: false
    t.float "start_time_sec", null: false
    t.boolean "pause_at_start_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["desc_track_id"], name: "index_descriptions_on_desc_track_id"
  end

  create_table "generated_descriptions", primary_key: "description_id", force: :cascade do |t|
    t.string "audio_file_loc", null: false
    t.text "description_text", null: false
    t.bigint "tts_voice_id", null: false
    t.float "tts_speed", default: 1.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tts_voice_id"], name: "index_generated_descriptions_on_tts_voice_id"
  end

  create_table "recorded_descriptions", primary_key: "description_id", force: :cascade do |t|
    t.string "audio_file_loc", null: false
    t.text "description_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.jsonb "options", default: {"default_lang"=>"en"}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "yt_video_id", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "voices", force: :cascade do |t|
    t.string "common_name", null: false
    t.string "system_name", null: false
    t.string "provider", null: false
  end

  add_foreign_key "description_tracks", "users", column: "track_author_id"
  add_foreign_key "description_tracks", "videos"
  add_foreign_key "descriptions", "description_tracks", column: "desc_track_id"
  add_foreign_key "generated_descriptions", "voices", column: "tts_voice_id"
end
