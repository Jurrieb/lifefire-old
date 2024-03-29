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

ActiveRecord::Schema.define(version: 20140724143446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: true do |t|
    t.integer  "user_id"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["user_id"], name: "index_achievements_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
    t.integer  "message_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

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

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "accepted",   default: false
    t.boolean  "rejected",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id", "user_id"], name: "index_friendships_on_user_id_and_user_id", using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "message"
    t.integer  "karma"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen",       default: false
    t.integer  "user_id"
    t.integer  "friend_id"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

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

  add_index "smokes", ["user_id"], name: "index_smokes_on_user_id", using: :btree

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

  add_index "sports", ["populair_sport_id"], name: "index_sports_on_populair_sport_id", using: :btree
  add_index "sports", ["user_id"], name: "index_sports_on_user_id", using: :btree

  create_table "user_details", force: true do |t|
    t.integer  "user_id"
    t.integer  "height",        default: 0
    t.integer  "weight",        default: 0
    t.integer  "target_weight", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_details", ["user_id"], name: "index_user_details_on_user_id", using: :btree

  create_table "user_notices", force: true do |t|
    t.integer  "user_id"
    t.boolean  "mail",          default: false
    t.boolean  "daily_updates", default: false
    t.boolean  "push_notice",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_notices", ["user_id"], name: "index_user_notices_on_user_id", using: :btree

  create_table "user_preferences", force: true do |t|
    t.integer  "user_id"
    t.boolean  "smokes",          default: false
    t.boolean  "sports",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_profile",  default: true
    t.boolean  "private_profile", default: true
  end

  add_index "user_preferences", ["user_id"], name: "index_user_preferences_on_user_id", using: :btree

  create_table "user_profiles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "user_smoke_addictions", force: true do |t|
    t.integer  "user_id"
    t.integer  "avarage_smokes_day", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_smoke_addictions", ["user_id"], name: "index_user_smoke_addictions_on_user_id", using: :btree

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
    t.string   "user_hash"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
