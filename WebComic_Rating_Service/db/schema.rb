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

ActiveRecord::Schema.define(version: 20150425001634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "claims", force: true do |t|
    t.integer  "comic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "claims", ["comic_id"], name: "index_comic_claim_id", using: :btree
  add_index "claims", ["user_id"], name: "index_user_claim_id", using: :btree

  create_table "comics", force: true do |t|
    t.string   "name"
    t.string   "author"
    t.string   "url"
    t.text     "synopsis"
    t.string   "genre"
    t.float    "rating_art"
    t.float    "rating_story"
    t.float    "rating_overall"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "update_schedule"
    t.string   "page_layout"
    t.integer  "rates"
    t.integer  "user_id",         default: 0
  end

  add_index "comics", ["user_id"], name: "index_user_comic_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.string   "has_rated"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
