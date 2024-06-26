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

ActiveRecord::Schema[7.1].define(version: 2024_01_12_102427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banners", force: :cascade do |t|
    t.string "banner_name"
    t.string "image_link"
    t.string "banner_link"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carted_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.integer "amount", null: false
    t.boolean "is_for_checkout", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "plant_type"
    t.string "growing_season"
    t.string "seed_varieties"
    t.string "planting_location"
    t.string "special_attributes"
    t.string "planting_method"
    t.string "package_size"
    t.integer "price"
    t.text "tags"
    t.text "image_links", default: ["https://placehold.co/600x400", "https://placehold.co/400x600", "https://placehold.co/400x400", "https://placehold.co/600x600"], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_reference", null: false
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.bigint "shipping_address_id", null: false
    t.bigint "payment_method_id", null: false
    t.integer "amount", null: false
    t.json "adjustments"
    t.integer "total", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "payment_type", null: false
    t.string "account_name", null: false
    t.string "card_number", null: false
    t.string "expiry_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.bigint "order_id", null: false
    t.boolean "is_anonymous", default: false
    t.integer "rating", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "contact_name", null: false
    t.string "contact_number", null: false
    t.string "street_address", null: false
    t.string "barangay", null: false
    t.string "city", null: false
    t.string "province", null: false
    t.string "region", null: false
    t.boolean "is_main", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "gender"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
