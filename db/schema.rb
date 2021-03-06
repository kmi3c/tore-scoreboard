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

ActiveRecord::Schema.define(version: 20151027075924) do

  create_table "users", force: :cascade do |t|
    t.string   "email",          limit: 255
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "p_first_name",   limit: 255
    t.string   "p_last_name",    limit: 255
    t.string   "nickname",       limit: 255
    t.string   "phone",          limit: 255
    t.text     "signature_json", limit: 65535
    t.string   "signature_uid",  limit: 255
    t.string   "signature_name", limit: 255
    t.boolean  "adult"
    t.boolean  "accept_r"
    t.boolean  "accept_m"
    t.integer  "day1",           limit: 4,     default: 0
    t.integer  "day2",           limit: 4,     default: 0
    t.integer  "day3",           limit: 4,     default: 0
    t.integer  "day4",           limit: 4,     default: 0
    t.integer  "day5",           limit: 4,     default: 0
    t.integer  "finale",         limit: 4,     default: 0
    t.integer  "score",          limit: 4,     default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

end
