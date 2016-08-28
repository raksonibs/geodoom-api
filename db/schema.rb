# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160828000134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balance_change_categories", force: :cascade do |t|
    t.integer  "balance_change_id"
    t.integer  "category_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "balance_change_categories", ["balance_change_id", "category_id"], name: "balance_change_categories_index", unique: true, using: :btree

  create_table "balance_changes", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.float    "value",                   null: false
    t.integer  "change_type", default: 0, null: false
    t.datetime "entry_date",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "battles", force: :cascade do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name"
    t.string   "challenged_email"
    t.string   "challenger_email"
    t.integer  "status",            default: 0
    t.integer  "challenger_pet_id"
    t.integer  "challenged_pet_id"
    t.integer  "current_turn"
  end

  create_table "battles_pets", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "pet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "battles_pets", ["battle_id"], name: "index_battles_pets_on_battle_id", using: :btree
  add_index "battles_pets", ["pet_id"], name: "index_battles_pets_on_pet_id", using: :btree

  create_table "battles_users", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "battles_users", ["battle_id"], name: "index_battles_users_on_battle_id", using: :btree
  add_index "battles_users", ["user_id"], name: "index_battles_users_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_stats", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id"
  end

  add_index "game_stats", ["game_id"], name: "index_game_stats_on_game_id", using: :btree
  add_index "game_stats", ["user_id"], name: "index_game_stats_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "games", ["user_id"], name: "index_games_on_user_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "pet_id"
    t.integer  "battle_id"
    t.integer  "user_id"
    t.string   "name"
    t.float    "defenceChange"
    t.float    "attackChange"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "pet_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "pet_id"
    t.float    "current_health"
    t.float    "current_defence"
    t.float    "current_attack"
    t.boolean  "shield"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.integer  "level",      default: 0
    t.integer  "vertices"
    t.integer  "user_id"
    t.string   "colour"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "pets", ["user_id"], name: "index_pets_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.integer  "battle_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "current_turn"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "stat_type",  default: 0, null: false
    t.float    "value",                  null: false
    t.integer  "pet_id",                 null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "currency",            default: "USD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "online"
    t.string   "uid"
    t.string   "nickname"
    t.string   "image"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_foreign_key "balance_change_categories", "balance_changes", on_delete: :cascade
  add_foreign_key "balance_change_categories", "categories", on_delete: :cascade
  add_foreign_key "balance_changes", "users", on_delete: :cascade
  add_foreign_key "game_stats", "games"
  add_foreign_key "game_stats", "users"
  add_foreign_key "games", "users"
end
