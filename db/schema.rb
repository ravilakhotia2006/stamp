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

ActiveRecord::Schema.define(version: 20170830180850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medical_records", force: :cascade do |t|
    t.string   "note"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medical_records_on_user_id", using: :btree
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string   "url"
    t.string   "description"
    t.integer  "medical_record_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["medical_record_id"], name: "index_prescriptions_on_medical_record_id", using: :btree
  end

  create_table "resource_mappings", force: :cascade do |t|
    t.integer  "medical_record_ids",              array: true
    t.integer  "accessing_user_id"
    t.integer  "resource_owner_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["accessing_user_id"], name: "index_resource_mappings_on_accessing_user_id", using: :btree
    t.index ["resource_owner_id"], name: "index_resource_mappings_on_resource_owner_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["user_id"], name: "index_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
