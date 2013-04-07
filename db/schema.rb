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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130407203600) do

  create_table "batting_seasons", :force => true do |t|
    t.integer  "season_order"
    t.string   "position"
    t.integer  "ab"
    t.integer  "gp"
    t.integer  "pa"
    t.integer  "singles"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "hr"
    t.integer  "tb"
    t.integer  "r"
    t.integer  "rbi"
    t.integer  "bb"
    t.integer  "ibb"
    t.integer  "so"
    t.integer  "hbp"
    t.integer  "sf"
    t.integer  "sh"
    t.integer  "gidp"
    t.integer  "sb"
    t.integer  "cs"
    t.float    "ba"
    t.float    "obp"
    t.float    "slg"
    t.float    "ops"
    t.float    "k_percent"
    t.float    "bb_percent"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "player_id"
  end

  create_table "pitching_seasons", :force => true do |t|
    t.integer  "season_order"
    t.integer  "gp"
    t.integer  "gs"
    t.integer  "w"
    t.integer  "l"
    t.integer  "sv"
    t.integer  "bs"
    t.integer  "hld"
    t.integer  "outs"
    t.integer  "tbf"
    t.integer  "h"
    t.integer  "r"
    t.integer  "er"
    t.integer  "hr"
    t.integer  "k"
    t.integer  "bb"
    t.integer  "ibb"
    t.integer  "hbp"
    t.integer  "cg"
    t.integer  "sho"
    t.integer  "wp"
    t.integer  "bk"
    t.float    "era"
    t.float    "whip"
    t.float    "k_percent"
    t.float    "bb_percent"
    t.float    "babip"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "player_id"
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.float    "height"
    t.float    "weight"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "team_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "abbreviation"
    t.string   "city"
    t.string   "team_name"
    t.string   "league"
    t.string   "division"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
