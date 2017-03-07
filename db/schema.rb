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

ActiveRecord::Schema.define(version: 20170307215632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issue_types", force: :cascade do |t|
    t.text     "issue_description"
    t.text     "default_priority"
    t.text     "when_to_resolve"
    t.date     "icon"
    t.string   "ok_icon_file_name"
    t.string   "ok_icon_content_type"
    t.integer  "ok_icon_file_size"
    t.datetime "ok_icon_updated_at"
    t.string   "nok_icon_file_name"
    t.string   "nok_icon_content_type"
    t.integer  "nok_icon_file_size"
    t.datetime "nok_icon_updated_at"
  end

  create_table "issues", force: :cascade do |t|
    t.integer "room_id"
    t.integer "issue_type_id"
    t.date    "requested_fix_date"
    t.text    "fix_comment"
    t.date    "timestamp"
    t.date    "completion_date"
    t.text    "priority"
    t.boolean "is_done",            default: false
    t.boolean "is_recurring",       default: false
    t.bigint  "event_id"
  end

  create_table "memos", force: :cascade do |t|
    t.integer  "room_id"
    t.text     "description"
    t.datetime "deadline"
    t.date     "completion_date"
    t.datetime "time_stamp"
    t.boolean  "is_done"
    t.boolean  "is_recurring",    default: false
    t.bigint   "event_id"
  end

  create_table "rooms", primary_key: "room_id", id: :integer, force: :cascade do |t|
    t.text    "description"
    t.boolean "is_clean"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
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
    t.integer  "role",                   default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
