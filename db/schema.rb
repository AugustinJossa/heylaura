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

ActiveRecord::Schema.define(version: 20170830152648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.float    "location_lat"
    t.float    "location_lng"
    t.string   "company_type"
    t.string   "industry"
    t.integer  "size"
    t.string   "description"
    t.string   "logo"
    t.string   "picture"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "job_loaders", force: :cascade do |t|
    t.string   "cname"
    t.string   "cpath"
    t.string   "clogourl"
    t.string   "title"
    t.string   "path"
    t.text     "tags"
    t.string   "city"
    t.text     "shortdesc"
    t.text     "detailtags"
    t.string   "imgurl"
    t.text     "deschtml"
    t.text     "desctext"
    t.text     "profilhtml"
    t.text     "profiltext"
    t.string   "img"
    t.string   "logo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ctype"
    t.string   "cindustry"
    t.string   "csize"
    t.integer  "jexperience"
    t.string   "jtype"
    t.string   "jsubtype"
    t.string   "jlocation"
    t.string   "jcontract"
    t.string   "jremote"
    t.integer  "jsalary"
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.string   "contract"
    t.string   "remote"
    t.float    "salary"
    t.string   "job_type"
    t.string   "subtype"
    t.string   "description"
    t.string   "profile"
    t.boolean  "open"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "company_id"
    t.integer  "experience"
    t.index ["company_id"], name: "index_jobs_on_company_id", using: :btree
  end

  create_table "matched_jobs", force: :cascade do |t|
    t.float    "matching"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "job_id"
    t.integer  "profile_id"
    t.index ["job_id"], name: "index_matched_jobs_on_job_id", using: :btree
    t.index ["profile_id"], name: "index_matched_jobs_on_profile_id", using: :btree
  end

  create_table "motivation_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "motivation_rankings", force: :cascade do |t|
    t.integer  "motivation_category_id"
    t.integer  "profile_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position"
    t.index ["motivation_category_id"], name: "index_motivation_rankings_on_motivation_category_id", using: :btree
    t.index ["profile_id"], name: "index_motivation_rankings_on_profile_id", using: :btree
  end

  create_table "profile_skills", force: :cascade do |t|
    t.text     "comment"
    t.integer  "skill_id"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_skills_on_profile_id", using: :btree
    t.index ["skill_id"], name: "index_profile_skills_on_skill_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "main_diploma"
    t.string   "main_school"
    t.string   "main_school_major_topic"
    t.string   "main_school_graduation_year"
    t.integer  "nb_years_experience"
    t.string   "company_type"
    t.string   "company_industry"
    t.string   "company_size"
    t.string   "job_type"
    t.string   "job_subtype"
    t.string   "job_location"
    t.string   "job_remote"
    t.string   "job_contract"
    t.integer  "job_min_salary"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "first_name"
    t.integer  "session_info"
    t.text     "raw_chat_content"
    t.integer  "i"
    t.integer  "icomp"
    t.integer  "ijob"
    t.integer  "iprofile"
    t.integer  "iaspir"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "required_skills", force: :cascade do |t|
    t.text     "comment"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "job_id"
    t.index ["job_id"], name: "index_required_skills_on_job_id", using: :btree
    t.index ["skill_id"], name: "index_required_skills_on_skill_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "linkedin_picture_url"
    t.string   "last_name"
    t.string   "headline"
    t.string   "location"
    t.string   "positions"
    t.string   "public_profil_url"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "admin",                  default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "companies", "users"
  add_foreign_key "jobs", "companies"
  add_foreign_key "matched_jobs", "jobs"
  add_foreign_key "matched_jobs", "profiles"
  add_foreign_key "motivation_rankings", "motivation_categories"
  add_foreign_key "motivation_rankings", "profiles"
  add_foreign_key "profile_skills", "profiles"
  add_foreign_key "profile_skills", "skills"
  add_foreign_key "profiles", "users"
  add_foreign_key "required_skills", "jobs"
  add_foreign_key "required_skills", "skills"
end
