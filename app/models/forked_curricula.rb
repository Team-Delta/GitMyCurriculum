# create_table "forked_curriculas", force: true do |t|
#   t.integer  "forked_to_curriculum_id",   null: false
#   t.integer  "forked_from_curriculum_id", null: false
#   t.datetime "created_at",                null: false
#   t.datetime "updated_at",                null: false
# end
class ForkedCurricula < ActiveRecord::Base
  belongs_to :forked_to_curriculum, class_name: Curricula
  belongs_to :forked_from_curriculum, class_name: Curricula
end
