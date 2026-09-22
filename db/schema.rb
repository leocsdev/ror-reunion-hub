# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_22_033008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "maiden_name"
    t.string "mobile"
    t.datetime "updated_at", null: false
  end

  create_table "reunion_memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "person_id", null: false
    t.bigint "reunion_id", null: false
    t.string "rsvp_token_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "reunion_id"], name: "index_reunion_memberships_on_person_id_and_reunion_id", unique: true
    t.index ["person_id"], name: "index_reunion_memberships_on_person_id"
    t.index ["reunion_id"], name: "index_reunion_memberships_on_reunion_id"
    t.index ["rsvp_token_digest"], name: "index_reunion_memberships_on_rsvp_token_digest", unique: true
  end

  create_table "reunions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "event_date", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reunion_memberships", "people"
  add_foreign_key "reunion_memberships", "reunions"
end
