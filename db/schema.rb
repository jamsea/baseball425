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

ActiveRecord::Schema.define(:version => 20130308030926) do

  create_table "batting_seasons", :force => true do |t|
    t.string   "team"
    t.integer  "jersey_number", :precision => 38, :scale => 0
    t.integer  "season_order",  :precision => 38, :scale => 0
    t.string   "position"
    t.integer  "ab",            :precision => 38, :scale => 0
    t.integer  "gp",            :precision => 38, :scale => 0
    t.integer  "pa",            :precision => 38, :scale => 0
    t.integer  "singles",       :precision => 38, :scale => 0
    t.integer  "doubles",       :precision => 38, :scale => 0
    t.integer  "triples",       :precision => 38, :scale => 0
    t.integer  "hr",            :precision => 38, :scale => 0
    t.integer  "tb",            :precision => 38, :scale => 0
    t.integer  "r",             :precision => 38, :scale => 0
    t.integer  "rbi",           :precision => 38, :scale => 0
    t.integer  "bb",            :precision => 38, :scale => 0
    t.integer  "ibb",           :precision => 38, :scale => 0
    t.integer  "so",            :precision => 38, :scale => 0
    t.integer  "hbp",           :precision => 38, :scale => 0
    t.integer  "sf",            :precision => 38, :scale => 0
    t.integer  "sh",            :precision => 38, :scale => 0
    t.integer  "gidp",          :precision => 38, :scale => 0
    t.integer  "sb",            :precision => 38, :scale => 0
    t.integer  "cs",            :precision => 38, :scale => 0
    t.decimal  "ba"
    t.decimal  "obp"
    t.decimal  "slg"
    t.decimal  "ops"
    t.decimal  "k_percent"
    t.decimal  "bb_percent"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "department", :primary_key => "department_id", :force => true do |t|
    t.string "name",     :limit => 30, :null => false
    t.string "location", :limit => 30
  end

  create_table "employee", :primary_key => "employee_id", :force => true do |t|
    t.string   "last_name",     :limit => 10
    t.string   "first_name",    :limit => 10
    t.string   "sin_number",    :limit => 9
    t.datetime "date_of_birth"
    t.integer  "department_id", :limit => 2,  :precision => 2, :scale => 0
    t.string   "email",         :limit => 30
  end

  create_table "inv", :primary_key => "partno", :force => true do |t|
    t.string  "description", :limit => 25
    t.integer "qonhand",     :limit => 5,  :precision => 5, :scale => 0
  end

  create_table "j", :primary_key => "jno", :force => true do |t|
    t.string "jname", :limit => 10
    t.string "city",  :limit => 10
  end

  create_table "p", :primary_key => "pno", :force => true do |t|
    t.string  "pname",  :limit => 10
    t.string  "color",  :limit => 5
    t.decimal "weight",               :precision => 5, :scale => 2
    t.string  "city",   :limit => 10
  end

  create_table "pitching_seasons", :force => true do |t|
    t.string   "team"
    t.integer  "jersey_number", :precision => 38, :scale => 0
    t.integer  "season_order",  :precision => 38, :scale => 0
    t.integer  "gp",            :precision => 38, :scale => 0
    t.integer  "gs",            :precision => 38, :scale => 0
    t.integer  "w",             :precision => 38, :scale => 0
    t.integer  "l",             :precision => 38, :scale => 0
    t.integer  "sv",            :precision => 38, :scale => 0
    t.integer  "bs",            :precision => 38, :scale => 0
    t.integer  "hld",           :precision => 38, :scale => 0
    t.integer  "outs",          :precision => 38, :scale => 0
    t.integer  "tbf",           :precision => 38, :scale => 0
    t.integer  "h",             :precision => 38, :scale => 0
    t.integer  "r",             :precision => 38, :scale => 0
    t.integer  "er",            :precision => 38, :scale => 0
    t.integer  "hr",            :precision => 38, :scale => 0
    t.integer  "k",             :precision => 38, :scale => 0
    t.integer  "bb",            :precision => 38, :scale => 0
    t.integer  "ibb",           :precision => 38, :scale => 0
    t.integer  "hbp",           :precision => 38, :scale => 0
    t.integer  "cg",            :precision => 38, :scale => 0
    t.integer  "sho",           :precision => 38, :scale => 0
    t.integer  "wp",            :precision => 38, :scale => 0
    t.integer  "bk",            :precision => 38, :scale => 0
    t.decimal  "era"
    t.decimal  "whip"
    t.decimal  "k_percent"
    t.decimal  "bb_percent"
    t.decimal  "babip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "date_of_birth"
    t.decimal  "height"
    t.decimal  "weight"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "quot", :id => false, :force => true do |t|
    t.integer "suppno",        :limit => 5,  :precision => 5,  :scale => 0, :null => false
    t.integer "partno",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.decimal "price",                       :precision => 7,  :scale => 2
    t.integer "delivery_time", :limit => 2,  :precision => 2,  :scale => 0
    t.integer "qonorder",      :limit => 3,  :precision => 3,  :scale => 0
  end

  create_table "quotations", :id => false, :force => true do |t|
    t.integer "sno",      :precision => 38, :scale => 0, :null => false
    t.integer "pno",      :precision => 38, :scale => 0, :null => false
    t.decimal "price"
    t.integer "del_time", :precision => 38, :scale => 0
    t.integer "on_order", :precision => 38, :scale => 0
  end

  create_table "s", :primary_key => "sno", :force => true do |t|
    t.string  "sname",  :limit => 10
    t.integer "status", :limit => 5,  :precision => 5, :scale => 0
    t.string  "city",   :limit => 10
  end

  create_table "spj", :id => false, :force => true do |t|
    t.string  "sno", :limit => 3,                               :null => false
    t.string  "pno", :limit => 3,                               :null => false
    t.string  "jno", :limit => 3,                               :null => false
    t.integer "qty", :limit => 3, :precision => 3, :scale => 0
  end

  create_table "supp", :primary_key => "supno", :force => true do |t|
    t.string "name",    :limit => 25
    t.string "address", :limit => 35
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

  add_foreign_key "quot", "inv", :column => "partno", :primary_key => nil, :name => "fk_partno_in_quot"
  add_foreign_key "quot", "supp", :column => "suppno", :primary_key => nil, :name => "fk_suppno_in_quot"

  add_foreign_key "quotations", "inv", :column => "pno", :primary_key => nil, :name => "part#_fk"
  add_foreign_key "quotations", "supp", :column => "sno", :primary_key => nil, :name => "supp#_fk"

  add_foreign_key "spj", "j", :column => "jno", :primary_key => nil, :name => "fk_jno_in_j"
  add_foreign_key "spj", "p", :column => "pno", :primary_key => nil, :name => "fk_pno_in_p"
  add_foreign_key "spj", "s", :column => "sno", :primary_key => nil, :name => "fk_sno_in_s"

end
