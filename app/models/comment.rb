# create_table "comments", force: true do |t|
#   t.integer  "creator_id",        null: false
#   t.integer  "join_request_id",   null: false
#   t.integer  "parent_comment_id"
#   t.text     "message",           null: false
#   t.datetime "created_at",        null: false
#   t.datetime "updated_at",        null: false
# end
class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User'
  belongs_to :join_request, foreign_key: 'join_request_id', class_name: 'JoinRequest'
  belongs_to :parent_comment, class_name: 'Comment'

  # self referential relationship, a comment can have many child comments
  has_many :comments, foreign_key: 'parent_comment_id'

  class << self
    
  end
end