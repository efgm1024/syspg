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

ActiveRecord::Schema.define(version: 20160413044357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academies", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "user_id"
    t.integer  "campu_id"
    t.integer  "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assignment_submissions", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.decimal  "grade",                        precision: 5, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "assignment_file_file_name"
    t.string   "assignment_file_content_type"
    t.integer  "assignment_file_file_size"
    t.datetime "assignment_file_updated_at"
    t.string   "counseling_file_file_name"
    t.string   "counseling_file_content_type"
    t.integer  "counseling_file_file_size"
    t.datetime "counseling_file_updated_at"
  end

  create_table "assignments", force: :cascade do |t|
    t.string   "name"
    t.string   "dead_line"
    t.string   "assignment_type"
    t.string   "description"
    t.decimal  "total_grade",     precision: 5, scale: 2
    t.integer  "classroom_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "campus", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.string   "section"
    t.integer  "academy_id"
    t.integer  "subject_id"
    t.integer  "quarter_id"
    t.integer  "major_id"
    t.integer  "campu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms_students", force: :cascade do |t|
    t.integer "classroom_id"
    t.integer "student_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "web_site"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "contact_job_title"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "company_category_id"
  end

  create_table "company_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "professional_practice_id"
    t.integer  "graduation_project_id"
    t.boolean  "verified",                 default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frequently_asked_questions", force: :cascade do |t|
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "graduation_projects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "objective"
    t.string   "requirements"
    t.boolean  "active",       default: true
    t.integer  "company_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "graduation_projects_majors", force: :cascade do |t|
    t.integer "graduation_project_id"
    t.integer "major_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "majors_professional_practices", force: :cascade do |t|
    t.integer "major_id"
    t.integer "professional_practice_id"
  end

  create_table "professional_practices", force: :cascade do |t|
    t.string   "area"
    t.string   "charge"
    t.string   "objective"
    t.string   "daily_tasks"
    t.string   "observation"
    t.string   "boss_name"
    t.string   "boss_email"
    t.string   "check_in"
    t.string   "check_out"
    t.boolean  "hire_probability", default: false
    t.boolean  "flexitime",        default: false
    t.boolean  "active",           default: true
    t.integer  "company_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "quarters", force: :cascade do |t|
    t.integer  "period"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "unitec_id"
    t.string   "phone"
    t.boolean  "available",  default: true
    t.integer  "user_id"
    t.integer  "campu_id"
    t.integer  "major_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.string   "verified",               default: "f"
    t.string   "role",                   default: ""
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
