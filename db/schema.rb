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

ActiveRecord::Schema.define(version: 20140708140347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friends_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "messages", force: true do |t|
    t.string   "message"
    t.integer  "karma"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen",       default: false
    t.integer  "user_id"
  end

  create_table "populair_sports", force: true do |t|
    t.string   "name"
    t.integer  "kcal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smokes", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.integer  "counted",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", force: true do |t|
    t.integer  "user_id"
    t.integer  "populair_sport_id"
    t.date     "date"
    t.integer  "duration"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "burned_calories",   default: 0
  end

  create_table "user_details", force: true do |t|
    t.integer  "user_id"
    t.integer  "height",        default: 0
    t.integer  "weight",        default: 0
    t.integer  "target_weight", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_notices", force: true do |t|
    t.integer  "user_id"
    t.boolean  "mail",          default: false
    t.boolean  "daily_updates", default: false
    t.boolean  "push_notice",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_preferences", force: true do |t|
    t.integer  "user_id"
    t.boolean  "smokes",          default: false
    t.boolean  "sports",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_profile",  default: false
    t.boolean  "private_profile", default: false
  end

  create_table "user_profiles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_smoke_addictions", force: true do |t|
    t.integer  "user_id"
    t.integer  "avarage_smokes_day", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "karma",                  default: 0
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
