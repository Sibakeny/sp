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

ActiveRecord::Schema.define(version: 2021_03_16_075141) do

  create_table "sp_settings", force: :cascade do |t|
    t.string "sso_url"
    t.string "slo_url"
    t.string "x509_certificate"
    t.string "certificate_fingerprint"
    t.string "certificate_fingerprint_algorithm"
    t.string "name_id_format"
    t.string "sso_http_binding"
    t.string "slo_http_binding"
    t.string "authn_context"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "entity_id"
    t.index ["user_id"], name: "index_sp_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end