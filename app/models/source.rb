# create_table "sources", force: true do |t|
#   t.integer  "curricula_id", null: false
#   t.integer  "creator_id",   null: false
#   t.string   "author"
#   t.string   "title"
#   t.string   "source_tag"
#   t.datetime "created_at",   null: false
#   t.datetime "updated_at",   null: false
#   t.datetime "written_at"
# end
class Source < ActiveRecord::Base
  belongs_to :curricula, foreign_key: 'curriculum_id'
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User'
end
