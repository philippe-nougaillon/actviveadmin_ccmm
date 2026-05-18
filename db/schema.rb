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

ActiveRecord::Schema[8.1].define(version: 2026_05_12_150828) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.integer "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "namespace"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "adherents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.text "memo"
    t.string "nom_contact"
    t.string "nom_ville"
    t.datetime "updated_at", null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "nom"
    t.integer "prix_ht"
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.string "action"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "auditable_id"
    t.string "auditable_type"
    t.text "audited_changes"
    t.string "comment"
    t.datetime "created_at"
    t.string "remote_address"
    t.string "request_uuid"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.integer "version", default: 0
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "cotation_lignes", force: :cascade do |t|
    t.integer "cotation_id", null: false
    t.datetime "created_at", null: false
    t.string "intitulé"
    t.integer "prestation_id", null: false
    t.decimal "prix_ht", precision: 8, scale: 2
    t.integer "qté"
    t.virtual "total_ht", type: :integer, as: "prix_ht * qté", stored: true
    t.datetime "updated_at", null: false
    t.index ["cotation_id"], name: "index_cotation_lignes_on_cotation_id"
    t.index ["prestation_id"], name: "index_cotation_lignes_on_prestation_id"
  end

  create_table "cotations", force: :cascade do |t|
    t.integer "adherent_id", null: false
    t.datetime "created_at", null: false
    t.date "date_livraison_souhaitée"
    t.string "intitulé"
    t.text "mémo"
    t.string "ref"
    t.integer "statut", default: 0
    t.decimal "total_ht", precision: 8, scale: 2
    t.datetime "updated_at", null: false
    t.index ["adherent_id"], name: "index_cotations_on_adherent_id"
  end

  create_table "prestations", force: :cascade do |t|
    t.string "catégorie"
    t.string "code"
    t.string "compétence"
    t.datetime "created_at", null: false
    t.string "description"
    t.string "délai"
    t.string "libellé"
    t.string "sous_catégorie"
    t.decimal "tarif", precision: 8, scale: 2
    t.string "unité"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cotation_lignes", "cotations"
  add_foreign_key "cotation_lignes", "prestations"
  add_foreign_key "cotations", "adherents"
end
