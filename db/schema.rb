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

ActiveRecord::Schema.define(version: 2018_11_08_164236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "localities", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.bigint "status_id"
    t.bigint "region_id"
    t.bigint "state_id"
    t.bigint "country_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_localities_on_country_id"
    t.index ["region_id"], name: "index_localities_on_region_id"
    t.index ["state_id"], name: "index_localities_on_state_id"
    t.index ["status_id"], name: "index_localities_on_status_id"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.bigint "brand_id"
    t.bigint "country_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_manufacturers_on_brand_id"
    t.index ["country_id"], name: "index_manufacturers_on_country_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.bigint "state_id"
    t.bigint "country_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
    t.index ["state_id"], name: "index_regions_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.bigint "country_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "localities", "countries"
  add_foreign_key "localities", "regions"
  add_foreign_key "localities", "states"
  add_foreign_key "localities", "statuses"
  add_foreign_key "manufacturers", "brands"
  add_foreign_key "manufacturers", "countries"
  add_foreign_key "regions", "countries"
  add_foreign_key "regions", "states"
  add_foreign_key "states", "countries"
end
