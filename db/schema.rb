# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170505194621) do

  create_table "alternatives", force: :cascade do |t|
    t.string   "content"
    t.integer  "challenge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["challenge_id"], name: "index_alternatives_on_challenge_id"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "breeds", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "game_id"
    t.index ["game_id"], name: "index_breeds_on_game_id"
  end

  create_table "breeds_characters", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "breed_id",     null: false
    t.index ["character_id", "breed_id"], name: "index_breeds_characters_on_character_id_and_breed_id", unique: true
  end

  create_table "breeds_particulars", id: false, force: :cascade do |t|
    t.integer "breed_id",      null: false
    t.integer "particular_id", null: false
    t.index ["breed_id", "particular_id"], name: "index_breeds_particulars_on_breed_id_and_particular_id", unique: true
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "game_id"
    t.integer  "history_id"
    t.index ["game_id"], name: "index_challenges_on_game_id"
    t.index ["history_id"], name: "index_challenges_on_history_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "game_id"
    t.index ["game_id"], name: "index_characters_on_game_id"
  end

  create_table "characters_skills", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "skill_id",     null: false
    t.index ["character_id", "skill_id"], name: "index_characters_skills_on_character_id_and_skill_id", unique: true
  end

  create_table "effects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "value"
    t.integer  "duration"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friend_list", force: :cascade do |t|
    t.integer "first_friend_id"
    t.integer "second_friend_id"
    t.index ["first_friend_id"], name: "index_friend_list_on_first_friend_id"
    t.index ["second_friend_id"], name: "index_friend_list_on_second_friend_id"
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "games_histories", id: false, force: :cascade do |t|
    t.integer "game_id",    null: false
    t.integer "history_id", null: false
    t.index ["game_id", "history_id"], name: "index_games_histories_on_game_id_and_history_id", unique: true
  end

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
    t.index ["game_id", "user_id"], name: "index_games_users_on_game_id_and_user_id", unique: true
  end

  create_table "histories", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "effect_id"
    t.integer  "game_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["effect_id"], name: "index_items_on_effect_id"
    t.index ["game_id"], name: "index_items_on_game_id"
  end

  create_table "maps", force: :cascade do |t|
    t.string   "name"
    t.text     "json_map"
    t.integer  "rows"
    t.integer  "columns"
    t.integer  "history_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["history_id"], name: "index_maps_on_history_id"
  end

  create_table "particulars", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "age"
    t.string   "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
