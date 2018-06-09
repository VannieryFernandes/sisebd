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

ActiveRecord::Schema.define(version: 20180526120700) do

  create_table "folha_semanals", force: :cascade do |t|
    t.integer "usuario_turma_id"
    t.boolean "presente"
    t.boolean "trouxe_biblia"
    t.boolean "trouxe_licao"
    t.integer "capitulos_lidos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "oferta"
    t.index ["usuario_turma_id"], name: "index_folha_semanals_on_usuario_turma_id"
  end

  create_table "perfils", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turmas", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuario_turmas", force: :cascade do |t|
    t.integer "turma_id"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["turma_id"], name: "index_usuario_turmas_on_turma_id"
    t.index ["usuario_id"], name: "index_usuario_turmas_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome"
    t.boolean "visitante"
    t.datetime "data_nascimento"
    t.string "matricula"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_usuarios_on_perfil_id"
  end

end
