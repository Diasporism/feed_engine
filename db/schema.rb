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

ActiveRecord::Schema.define(:version => 20130522003441) do

  create_table "emails", :force => true do |t|
    t.integer  "provider_id"
    t.string   "from"
    t.string   "subject"
    t.text     "body"
    t.string   "uid"
    t.datetime "received_at"
  end

  add_index "emails", ["provider_id"], :name => "index_emails_on_provider_id"

  create_table "providers", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "refresh_token"
  end

  add_index "providers", ["user_id"], :name => "index_providers_on_user_id"

  create_table "tweets", :force => true do |t|
    t.integer  "provider_id"
    t.string   "tweet_id"
    t.string   "text"
    t.string   "screen_name"
    t.string   "profile_image_url"
    t.datetime "received_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "tweets", ["provider_id"], :name => "index_tweets_on_provider_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
