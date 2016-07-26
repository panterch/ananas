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

ActiveRecord::Schema.define(version: 20160726153136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "state",      default: 0
    t.integer  "guest_id"
    t.string   "guest_type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["event_id"], name: "index_attendances_on_event_id", using: :btree
    t.index ["guest_type", "guest_id"], name: "index_attendances_on_guest_type_and_guest_id", using: :btree
  end

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
    t.index ["mentor_id"], name: "index_events_on_mentor_id", using: :btree
    t.index ["start_at"], name: "index_events_on_start_at", using: :btree
    t.index ["team_id"], name: "index_events_on_team_id", using: :btree
    t.index ["type"], name: "index_events_on_type", using: :btree
  end

  create_table "has_vcards_addresses", force: :cascade do |t|
    t.string   "post_office_box"
    t.string   "extended_address"
    t.string   "street_address"
    t.string   "locality"
    t.string   "region"
    t.string   "postal_code"
    t.string   "country_name"
    t.integer  "vcard_id"
    t.string   "address_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["vcard_id"], name: "addresses_vcard_id_index", using: :btree
  end

  create_table "has_vcards_phone_numbers", force: :cascade do |t|
    t.string   "number"
    t.string   "phone_number_type"
    t.integer  "vcard_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["phone_number_type"], name: "index_has_vcards_phone_numbers_on_phone_number_type", using: :btree
    t.index ["vcard_id"], name: "phone_numbers_vcard_id_index", using: :btree
  end

  create_table "has_vcards_vcards", force: :cascade do |t|
    t.string   "full_name"
    t.string   "nickname"
    t.string   "family_name"
    t.string   "given_name"
    t.string   "additional_name"
    t.string   "honorific_prefix"
    t.string   "honorific_suffix"
    t.boolean  "active",           default: true
    t.string   "type"
    t.integer  "reference_id"
    t.string   "reference_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["active"], name: "index_has_vcards_vcards_on_active", using: :btree
    t.index ["reference_id", "reference_type"], name: "index_has_vcards_vcards_on_reference_id_and_reference_type", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
  end

  create_table "mentors", force: :cascade do |t|
    t.string   "job_title"
    t.text     "who_i_am"
    t.text     "experience"
    t.text     "interests"
    t.text     "motivation"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "avatar"
    t.integer  "team_mentors_count", default: 0
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "event_id"
    t.integer  "mentor_id"
    t.json     "votes"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ratings_on_event_id", using: :btree
    t.index ["mentor_id"], name: "index_ratings_on_mentor_id", using: :btree
    t.index ["team_id"], name: "index_ratings_on_team_id", using: :btree
  end

  create_table "team_members", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_team_members_on_member_id", using: :btree
    t.index ["team_id"], name: "index_team_members_on_team_id", using: :btree
  end

  create_table "team_mentors", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "mentor_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_id"], name: "index_team_mentors_on_mentor_id", using: :btree
    t.index ["team_id"], name: "index_team_mentors_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "profile_id"
    t.string   "profile_type"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["profile_id"], name: "index_users_on_profile_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "attendances", "events"
  add_foreign_key "ratings", "events"
  add_foreign_key "ratings", "mentors"
  add_foreign_key "ratings", "teams"
  add_foreign_key "team_members", "members"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_mentors", "mentors"
  add_foreign_key "team_mentors", "teams"
end
