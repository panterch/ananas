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

ActiveRecord::Schema.define(version: 20160523122213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "summary",     null: false
    t.string   "description"
    t.datetime "start_at",    null: false
    t.datetime "end_at",      null: false
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "type"
    t.integer  "mentor_id"
    t.integer  "team_id"
  end

  add_index "events", ["mentor_id"], name: "index_events_on_mentor_id", using: :btree
  add_index "events", ["start_at"], name: "index_events_on_start_at", using: :btree
  add_index "events", ["team_id"], name: "index_events_on_team_id", using: :btree
  add_index "events", ["type"], name: "index_events_on_type", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mentors", force: :cascade do |t|
    t.string   "job_title"
    t.text     "who_i_am"
    t.text     "experience"
    t.text     "interests"
    t.text     "motivation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "team_members", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_members", ["member_id"], name: "index_team_members_on_member_id", using: :btree
  add_index "team_members", ["team_id"], name: "index_team_members_on_team_id", using: :btree

  create_table "team_mentors", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "mentor_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_mentors", ["mentor_id"], name: "index_team_mentors_on_mentor_id", using: :btree
  add_index "team_mentors", ["team_id"], name: "index_team_mentors_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "team_members", "members"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_mentors", "mentors"
  add_foreign_key "team_mentors", "teams"
end
