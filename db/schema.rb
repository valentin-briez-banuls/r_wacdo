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

ActiveRecord::Schema[8.0].define(version: 2025_05_29_221310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"

  create_table "affectations", force: :cascade do |t|
    t.bigint "collaborateur_id", null: false
    t.bigint "restaurant_id", null: false
    t.bigint "fonction_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collaborateur_id"], name: "index_affectations_on_collaborateur_id"
    t.index ["fonction_id"], name: "index_affectations_on_fonction_id"
    t.index ["restaurant_id"], name: "index_affectations_on_restaurant_id"
  end

  create_table "collaborateurs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "first_name"
    t.string "last_name"
    t.date "hire_date"
    t.boolean "can_access"
    t.index ["email"], name: "index_collaborateurs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_collaborateurs_on_reset_password_token", unique: true
  end

  create_table "fonctions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "affectations", "collaborateurs"
  add_foreign_key "affectations", "fonctions"
  add_foreign_key "affectations", "restaurants"
end
