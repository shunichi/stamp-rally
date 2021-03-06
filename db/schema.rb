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

ActiveRecord::Schema.define(version: 20150627181739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stamps", force: :cascade do |t|
    t.integer  "trainee_id", null: false
    t.integer  "master_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stamps", ["trainee_id", "master_id"], name: "index_stamps_on_trainee_id_and_master_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "provider",                     null: false
    t.string   "uid",                          null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "auth_hash",                    null: false
    t.integer  "user_type",        default: 0, null: false
    t.datetime "rally_started_at"
    t.string   "token",                        null: false
    t.integer  "remotty_entry_id"
    t.string   "icon_url",                     null: false
  end

end
