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

ActiveRecord::Schema.define(version: 2021_03_29_211750) do

  # These are extensions that must be enabled in order to support this database
  #enable_extension "adminpack"
  enable_extension "plpgsql"
  enable_extension "sslinfo"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "announcements", id: :serial, force: :cascade do |t|
    t.string "message", limit: 255, null: false
    t.boolean "admin_only", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_files", id: :serial, force: :cascade do |t|
    t.integer "diagram_id"
    t.string "name", limit: 255
    t.string "data_file_file_name", limit: 255
    t.string "data_file_content_type", limit: 255
    t.integer "data_file_file_size"
    t.datetime "data_file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagrams", id: :serial, force: :cascade do |t|
    t.integer "institution_id"
    t.integer "creator_id", null: false
    t.string "name", limit: 255
    t.string "category", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data_format", limit: 255
    t.text "description"
    t.boolean "downloadable", default: false
    t.boolean "share_with_all", default: false
    t.boolean "share_with_all_institutions", default: false
    t.boolean "local", default: false
    t.index ["institution_id"], name: "index_diagrams_on_institution_id"
  end

  create_table "institutions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "royce_connector", id: :serial, force: :cascade do |t|
    t.integer "roleable_id", null: false
    t.string "roleable_type", limit: 255, null: false
    t.integer "role_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["role_id"], name: "index_royce_connector_on_role_id"
    t.index ["roleable_id", "roleable_type"], name: "index_royce_connector_on_roleable_id_and_roleable_type"
  end

  create_table "royce_role", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_royce_role_on_name"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_diagrams", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "diagram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["diagram_id"], name: "index_user_diagrams_on_diagram_id"
    t.index ["user_id"], name: "index_user_diagrams_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "institution_id"
    t.boolean "super_admin", default: false
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "title", limit: 255
    t.string "department", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.boolean "approved", default: false, null: false
    t.boolean "do_not_mail", default: false
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["institution_id"], name: "index_users_on_institution_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
