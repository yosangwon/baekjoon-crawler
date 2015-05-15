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

ActiveRecord::Schema.define(version: 20150515100049) do

  create_table "folders", force: :cascade do |t|
    t.string   "slug"
    t.string   "name"
    t.integer  "parent_folder_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "original_id"
    t.integer  "type",             default: 0, null: false
  end

  add_index "folders", ["original_id"], name: "index_folders_on_original_id"
  add_index "folders", ["parent_folder_id"], name: "index_folders_on_parent_folder_id"
  add_index "folders", ["slug"], name: "index_folders_on_slug"
  add_index "folders", ["type"], name: "index_folders_on_type"

  create_table "problem_folder_relations", force: :cascade do |t|
    t.integer "problem_id"
    t.integer "folder_id"
    t.integer "number"
  end

  add_index "problem_folder_relations", ["folder_id"], name: "index_problem_folder_relations_on_folder_id"
  add_index "problem_folder_relations", ["problem_id"], name: "index_problem_folder_relations_on_problem_id"

  create_table "problems", force: :cascade do |t|
    t.integer  "code"
    t.string   "title"
    t.integer  "trial"
    t.integer  "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "percentage"
  end

end
