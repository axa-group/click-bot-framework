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

ActiveRecord::Schema.define(version: 20170710144120) do

  create_table "custom_loggers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "started_at"
    t.datetime "completed_at"
    t.string "namespace"
    t.string "message"
    t.text "error_messages"
    t.integer "alert_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "off_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language_code", default: "en"
    t.string "action_hook"
    t.string "confirmation"
  end

  create_table "platforms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "verify_token"
    t.string "access_token"
    t.text "decision_tree_xml", limit: 4294967295
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "nlp_cloud_service_enabled", default: false
    t.string "api_ai_client_access_token"
    t.string "language_code", default: "en"
    t.float "threshold", limit: 24, default: 0.2
  end

  create_table "platforms_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "platform_id", null: false
    t.bigint "user_id", null: false
    t.index ["platform_id", "user_id"], name: "index_platforms_users_on_platform_id_and_user_id"
    t.index ["user_id", "platform_id"], name: "index_platforms_users_on_user_id_and_platform_id"
  end

  create_table "training_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "off_topic_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["off_topic_id"], name: "index_training_messages_on_off_topic_id"
  end

  create_table "user_sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "facebook_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "node_id"
    t.integer "off_topic_id"
    t.integer "platform_id"
    t.index ["facebook_user_id"], name: "index_user_sessions_on_facebook_user_id"
    t.index ["platform_id"], name: "index_user_sessions_on_platform_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
