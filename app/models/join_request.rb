# create_table "join_requests", force: true do |t|
#   t.integer  "creator_id",                    null: false
#   t.integer  "curriculum_id",                 null: false
#   t.string   "target_stream",                 null: false
#   t.string   "source_stream",                 null: false
#   t.boolean  "closed",        default: false, null: false
#   t.boolean  "status"
#   t.text     "message"
#   t.datetime "created_at",                    null: false
#   t.datetime "updated_at",                    null: false
# end
class JoinRequest < ActiveRecord::Base
  belongs_to :curricula, foreign_key: 'curriculum_id'
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User'

  has_many :comments, dependent: :destroy

  class << self
  end
end
