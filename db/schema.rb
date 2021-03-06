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

ActiveRecord::Schema.define(version: 2020_03_16_210703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.string "quantity", default: "no", null: false
    t.decimal "cost", precision: 10, scale: 2
    t.bigint "group_id"
    t.index ["group_id"], name: "index_materials_on_group_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "minutes", limit: 2
    t.integer "seconds", limit: 2
    t.decimal "rate", precision: 10, scale: 2
  end

  add_foreign_key "materials", "groups"
end
