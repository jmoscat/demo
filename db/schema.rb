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

ActiveRecord::Schema.define(:version => 20121110150938) do

  create_table "clients", :force => true do |t|
    t.string   "twitter_name",    :null => false
    t.string   "twitter_user_id"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "clients", ["twitter_name"], :name => "index_clients_on_twitter_name"

  create_table "demo_ieses", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discounts", :force => true do |t|
    t.string   "hash_key"
    t.string   "user_id",     :null => false
    t.string   "client_id"
    t.text     "description"
    t.boolean  "used"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "discounts", ["hash_key"], :name => "index_discounts_on_hash_key"

  create_table "tweets", :force => true do |t|
    t.string   "tweet_id",        :null => false
    t.string   "twitter_user_id"
    t.text     "tweet_text"
    t.string   "place"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "user_client_joins", :force => true do |t|
    t.string   "user_id",    :null => false
    t.string   "client_id",  :null => false
    t.integer  "visits"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_user_id"
    t.float    "influence"
    t.string   "tweet_username",                               :null => false
    t.string   "tweet_image_link"
    t.string   "tweet_user_link"
    t.float    "tweet_user_average_tweets_day"
    t.integer  "tweet_user_number_followers"
    t.integer  "tweet_user_number_following"
    t.string   "tweet_location"
    t.float    "ratio"
    t.integer  "profile_null"
    t.integer  "listed_count"
    t.integer  "retweet_count",                 :default => 0
    t.string   "geo_location"
    t.boolean  "verified"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "users", ["twitter_user_id"], :name => "index_users_on_twitter_user_id", :unique => true

  create_table "visits", :force => true do |t|
    t.string   "user_id",    :null => false
    t.string   "client_id",  :null => false
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
