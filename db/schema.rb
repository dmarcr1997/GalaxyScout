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

ActiveRecord::Schema.define(version: 2020_04_21_024524) do

  create_table "album_galaxies", force: :cascade do |t|
    t.integer "album_id"
    t.integer "galaxy_id"
  end

  create_table "album_planets", force: :cascade do |t|
    t.integer "album_id"
    t.integer "planet_id"
  end

  create_table "album_space_objs", force: :cascade do |t|
    t.integer "album_id"
    t.integer "space_obj_id"
  end

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
    t.text "options"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "album_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "galaxies", force: :cascade do |t|
    t.string "name"
    t.string "picture_src"
    t.text "bio"
    t.string "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.string "picture_src"
    t.text "bio"
    t.string "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "space_objs", force: :cascade do |t|
    t.string "name"
    t.string "picture_src"
    t.text "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "size"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "uid"
    t.string "image"
  end

end
