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

ActiveRecord::Schema[7.0].define(version: 2024_03_07_063236) do
  create_table "characters", force: :cascade do |t|
    t.integer "story_id", null: false
    t.string "name"
    t.string "gender"
    t.string "personality"
    t.string "job"
    t.string "introduce"
    t.string "evidence"
    t.boolean "is_criminal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.string "reason"
    t.string "stuff"
    t.index ["story_id"], name: "index_characters_on_story_id"
  end

  create_table "evidences", force: :cascade do |t|
    t.integer "character_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_evidences_on_character_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "character_id", null: false
    t.string "name"
    t.integer "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_players_on_character_id"
    t.index ["room_id"], name: "index_players_on_room_id"
  end

  create_table "queries", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "story_id"
    t.integer "character_id"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_rooms_on_character_id"
    t.index ["story_id"], name: "index_rooms_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.string "set"
    t.string "body"
    t.string "weapon"
    t.string "place"
    t.string "time"
    t.string "victim"
    t.string "v_gender"
    t.string "v_personality"
    t.string "v_job"
    t.string "all"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confession"
    t.string "c_stuff"
  end

  add_foreign_key "characters", "stories"
  add_foreign_key "evidences", "characters"
  add_foreign_key "players", "characters"
  add_foreign_key "players", "rooms"
  add_foreign_key "rooms", "characters"
  add_foreign_key "rooms", "stories"
end
