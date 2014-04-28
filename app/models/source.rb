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
  belongs_to :curricula
  belongs_to :creator, class_name: 'User'

  class << self
    def grab_sources_for_curriculum(curriculum)
      where('sources.curricula_id = ?', curriculum)
    end
  end
end
