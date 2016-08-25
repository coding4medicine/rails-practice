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

ActiveRecord::Schema.define(version: 20160824215952) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    default: 0,  null: false
    t.datetime "locked_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "image"
    t.float    "price"
    t.boolean  "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buy_books", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "card_id"
    t.datetime "purchase_date"
    t.float    "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "buy_plans", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "request_date"
    t.datetime "purchase_date"
    t.datetime "end_date"
    t.float    "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string   "stripe_token"
    t.integer  "user_id"
    t.integer  "last4"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "stripe_id"
    t.float    "price"
    t.datetime "interval"
    t.boolean  "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.string   "OldEmail"
    t.string   "NewEmail"
    t.integer  "old_id"
    t.integer  "new_id"
    t.boolean  "bonuspaid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sshkeys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stripe_events", force: :cascade do |t|
    t.string   "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
