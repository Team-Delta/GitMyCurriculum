class CreateCommentAndJoinRequest < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer  "creator_id",        null: false
      t.integer  "join_request_id",   null: false
      t.integer  "parent_comment_id"
      t.text     "message",           null: false
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

    create_table :join_requests do |t|
      t.integer  "creator_id",        null: false
      t.integer  "curriculum_id",     null: false
      t.string   "target_stream",     null: false
      t.string   "source_stream",     null: false
      t.boolean  "closed",            null: false,  default: false
      t.boolean  "status"
      t.text     "message"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end
  end
end
