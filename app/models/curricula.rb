# create_table 'curriculas', force: true do |t|
#   t.string   'cur_name',        default: '*subject to change*', null: false
#   t.text     'cur_description'
#   t.string   'path'
#   t.datetime 'created_at'
#   t.datetime 'updated_at'
#   t.boolean  'private_flag',    default: false,                 null: false
#   t.integer  'creator_id'
#   t.integer  'namespace_id'
#   t.boolean  'can_merge',       default: true,                  null: false
# end
class Curricula < ActiveRecord::Base
  has_many :user_curriculas
  has_many :users, through: :user_curriculas

  validates  :cur_description, length: { maximum: 2000 }, allow_blank: true

  searchable do
    text :cur_name
  end
end
