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

ActiveRecord::Schema.define(version: 20161209211236) do

  create_table "emails", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "text"
    t.integer  "user_id"
    t.integer  "partner_id"
    t.integer  "relationship_id"
    t.datetime "sent_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "sentiment"
    t.float    "score"
  end

  create_table "partners", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "partner_id"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "bio"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "oauth_token"
    t.string   "oauth_refresh_token"
    t.datetime "oauth_expires_at"
  end

end
