# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_07_163421) do

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.string "center"
    t.string "creator"
    t.text "description"
    t.string "nasa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "href"
    t.integer "user_id"
  end

  create_table "galaxies", force: :cascade do |t|
    t.string "name"
    t.string "picture_src"
    t.text "bio"
    t.string "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "album_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.string "picture_src"
    t.text "bio"
    t.string "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "album_id"
    t.integer "solar_system_id"
  end

  create_table "solar_systems", force: :cascade do |t|
    t.string "name"
    t.string "picture_src"
    t.text "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "album_id"
    t.integer "galaxy_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
