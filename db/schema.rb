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

ActiveRecord::Schema.define(version: 2021_03_13_041345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "description_tracks", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "track_author_id", null: false
    t.string "lang", limit: 2
    t.boolean "is_generated"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["track_author_id"], name: "index_description_tracks_on_track_author_id"
    t.index ["video_id"], name: "index_description_tracks_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.json "options"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "yt_video_id"
    t.boolean "deleted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "description_tracks", "users", column: "track_author_id"
  add_foreign_key "description_tracks", "videos"
end
