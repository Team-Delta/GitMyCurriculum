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
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User'

  has_many   :users_curriculas, dependent: :destroy
  has_many   :users, through: :users_curriculas

  validates  :creator, presence: true, on: :create
  validates  :cur_description, length: { maximum: 2000 }, allow_blank: true

  searchable do
    text :cur_name
  end
end
