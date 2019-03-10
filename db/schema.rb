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

ActiveRecord::Schema.define(version: 2019_03_08_195415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "bank_code"
    t.string "agency"
    t.string "agency_vd"
    t.string "account"
    t.string "account_vd"
    t.string "recipient_id"
    t.string "bank_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultations", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.datetime "start_time", default: "2019-03-10 02:20:59"
    t.datetime "end_time"
    t.index ["doctor_id"], name: "index_consultations_on_doctor_id"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "doctor_specialties", force: :cascade do |t|
    t.bigint "specialty_id"
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_specialties_on_doctor_id"
    t.index ["specialty_id"], name: "index_doctor_specialties_on_specialty_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "address"
    t.text "description"
    t.bigint "crm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "bank_code"
    t.string "agency"
    t.string "agency_vd"
    t.string "account"
    t.string "account_vd"
    t.string "recipient_id"
    t.integer "bank_account_id"
    t.string "status"
    t.text "academic_formation"
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "medical_records", force: :cascade do |t|
    t.bigint "user_id"
    t.string "blood"
    t.text "allergies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medical_records_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.string "method"
    t.bigint "consultation_id"
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.string "consultation_start_time"
    t.string "consultation_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id"], name: "index_orders_on_consultation_id"
    t.index ["doctor_id"], name: "index_orders_on_doctor_id"
    t.index ["patient_id"], name: "index_orders_on_patient_id"
  end

  create_table "patient_records", force: :cascade do |t|
    t.string "entry"
    t.bigint "patient_id"
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_patient_records_on_doctor_id"
    t.index ["patient_id"], name: "index_patient_records_on_patient_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.bigint "user_id"
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["doctor_id"], name: "index_reviews_on_doctor_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "phone"
    t.string "profile_picture", default: "nppyhs0fcrtswrejzk0h.png"
    t.string "cpf"
    t.datetime "birth_date"
    t.string "gender"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_days", force: :cascade do |t|
    t.integer "day"
    t.bigint "work_schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_schedule_id"], name: "index_work_days_on_work_schedule_id"
  end

  create_table "work_schedules", force: :cascade do |t|
    t.bigint "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_work_schedules_on_doctor_id"
  end

  add_foreign_key "admins", "users"
  add_foreign_key "consultations", "doctors"
  add_foreign_key "consultations", "users", column: "patient_id"
  add_foreign_key "doctor_specialties", "doctors"
  add_foreign_key "doctor_specialties", "specialties"
  add_foreign_key "doctors", "users"
  add_foreign_key "medical_records", "users"
  add_foreign_key "orders", "consultations"
  add_foreign_key "orders", "doctors"
  add_foreign_key "orders", "users", column: "patient_id"
  add_foreign_key "patient_records", "doctors"
  add_foreign_key "patient_records", "users", column: "patient_id"
  add_foreign_key "reviews", "doctors"
  add_foreign_key "reviews", "users"
  add_foreign_key "work_days", "work_schedules"
  add_foreign_key "work_schedules", "doctors"
end
