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

ActiveRecord::Schema.define(version: 20150304211815) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,     default: 0,  null: false
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "first_name",             limit: 255
    t.text     "invite_code",            limit: 65535
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "bids", force: :cascade do |t|
    t.decimal  "amount",                 precision: 10, scale: 2
    t.integer  "user_id",      limit: 4
    t.integer  "haircut_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bidding_year", limit: 4
  end

  add_index "bids", ["haircut_id"], name: "index_bids_on_haircut_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "haircuts", force: :cascade do |t|
    t.string   "member",              limit: 255
    t.text     "about",               limit: 65535
    t.string   "url",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",     limit: 255
    t.string   "photo_content_type",  limit: 255
    t.integer  "photo_file_size",     limit: 4
    t.datetime "photo_updated_at"
    t.boolean  "primary",             limit: 1,     default: false
    t.string   "primary_image_color", limit: 255
  end

  add_index "haircuts", ["url"], name: "index_haircuts_on_url", unique: true, using: :btree

  create_table "system_config", force: :cascade do |t|
    t.date     "close_bidding_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "current_bidding_year", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "first_name",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
