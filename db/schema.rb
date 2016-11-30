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

ActiveRecord::Schema.define(version: 20161130015803) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "committee_type"
  end

  create_table "calendars", force: :cascade do |t|
    t.string   "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.boolean "hidden"
    t.integer "custom_order"
    t.index ["custom_order"], name: "index_categories_on_custom_order"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "announcement_id"
    t.index ["announcement_id"], name: "index_comments_on_announcement_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "digestifier_receipts", force: :cascade do |t|
    t.string   "recipient_type", null: false
    t.integer  "recipient_id",   null: false
    t.datetime "captured_at",    null: false
    t.string   "digest",         null: false
    t.index ["digest"], name: "index_digestifier_receipts_on_digest"
    t.index ["recipient_type", "recipient_id", "digest"], name: "unique_digest_receipts", unique: true
  end

  create_table "digestifier_settings", force: :cascade do |t|
    t.string   "recipient_type",                null: false
    t.integer  "recipient_id",                  null: false
    t.text     "preferences",    default: "{}", null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "enabled",        default: true, null: false
    t.string   "identifier",                    null: false
    t.string   "digest",                        null: false
    t.index ["digest"], name: "index_digestifier_settings_on_digest"
    t.index ["identifier"], name: "index_digestifier_settings_on_identifier", unique: true
    t.index ["recipient_type", "recipient_id", "digest"], name: "unique_recipients", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "committee_type"
    t.integer  "category_id"
    t.integer  "custom_order"
    t.index ["custom_order"], name: "index_documents_on_custom_order"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.string   "description"
    t.datetime "date"
    t.string   "url"
    t.datetime "end"
  end

  create_table "expertises", force: :cascade do |t|
    t.boolean "constituency"
    t.string  "name"
  end

  create_table "read_sessions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "document_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer "user_id"
    t.integer "expertise_id"
    t.index ["expertise_id"], name: "index_user_skills_on_expertise_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                     default: "",                    null: false
    t.string   "encrypted_password",                        default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.boolean  "admin"
    t.datetime "last_sign_in_at",                           default: '2016-11-02 16:12:50', null: false
    t.boolean  "internal"
    t.boolean  "external"
    t.boolean  "executive"
    t.string   "digest_pref"
    t.string   "name"
    t.string   "board_role"
    t.string   "committee"
    t.text     "about_me",               limit: 4294967295
    t.text     "why_join",               limit: 4294967295
    t.boolean  "tilted"
    t.text     "ethnicity"
    t.text     "gender"
    t.text     "current_company"
    t.text     "current_position"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
