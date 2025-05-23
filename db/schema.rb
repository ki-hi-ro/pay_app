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

ActiveRecord::Schema[7.1].define(version: 2025_05_11_043157) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "debts", force: :cascade do |t|
    t.bigint "payment_id", null: false
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.integer "amount"
    t.boolean "paid"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_debts_on_from_user_id"
    t.index ["payment_id"], name: "index_debts_on_payment_id"
    t.index ["to_user_id"], name: "index_debts_on_to_user_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "payer_id"
    t.integer "amount"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payer_id"], name: "index_payments_on_payer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "debts", "payments"
  add_foreign_key "debts", "users", column: "from_user_id"
  add_foreign_key "debts", "users", column: "to_user_id"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "payments", "users", column: "payer_id"
end
