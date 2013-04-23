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

ActiveRecord::Schema.define(:version => 20130419074106) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "status_id"
    t.integer  "reply_comment_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "interests", ["topic_id"], :name => "index_interests_on_topic_id"
  add_index "interests", ["user_id", "topic_id"], :name => "index_interests_on_user_id_and_topic_id", :unique => true
  add_index "interests", ["user_id"], :name => "index_interests_on_user_id"

  create_table "joinforheater", :force => true do |t|
    t.integer "hater_id"
    t.integer "status_id"
  end

  add_index "joinforheater", ["hater_id", "status_id"], :name => "index_joinforheater_on_hater_id_and_status_id", :unique => true
  add_index "joinforheater", ["hater_id"], :name => "index_joinforheater_on_hater_id"
  add_index "joinforheater", ["status_id"], :name => "index_joinforheater_on_status_id"

  create_table "joinforliker", :force => true do |t|
    t.integer "liker_id"
    t.integer "status_id"
  end

  add_index "joinforliker", ["liker_id", "status_id"], :name => "index_joinforliker_on_liker_id_and_status_id", :unique => true
  add_index "joinforliker", ["liker_id"], :name => "index_joinforliker_on_liker_id"
  add_index "joinforliker", ["status_id"], :name => "index_joinforliker_on_status_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "statuses", :force => true do |t|
    t.text     "content"
    t.integer  "retweeted_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "statuses", ["created_at"], :name => "index_statuses_on_created_at"
  add_index "statuses", ["retweeted_id"], :name => "index_statuses_on_retweeted_id"
  add_index "statuses", ["user_id"], :name => "index_statuses_on_user_id"

  create_table "statuses_topics", :id => false, :force => true do |t|
    t.integer "status_id"
    t.integer "topic_id"
  end

  add_index "statuses_topics", ["status_id", "topic_id"], :name => "index_statuses_topics_on_status_id_and_topic_id", :unique => true
  add_index "statuses_topics", ["status_id"], :name => "index_statuses_topics_on_status_id"
  add_index "statuses_topics", ["topic_id"], :name => "index_statuses_topics_on_topic_id"

  create_table "topics", :force => true do |t|
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["tag"], :name => "index_topics_on_tag", :unique => true

  create_table "topics_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "topic_id"
  end

  add_index "topics_users", ["topic_id", "user_id"], :name => "index_topics_users_on_topic_id_and_user_id", :unique => true
  add_index "topics_users", ["topic_id"], :name => "index_topics_users_on_topic_id"
  add_index "topics_users", ["user_id"], :name => "index_topics_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "descript"
    t.string   "url"
    t.string   "gender"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "password_digest"
    t.datetime "refresh_at",      :default => '2013-04-19 02:16:01'
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token", :unique => true

end
