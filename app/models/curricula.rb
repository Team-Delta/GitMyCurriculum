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

  has_one :forked_curricula, foreign_key: 'forked_to_curriculum_id'
  has_one :forked_from_curriculum, through: :forked_curricula

  has_many :notifications, dependent: :destroy
  has_many :user_curriculas
  has_many :users, through: :user_curriculas

  validates  :cur_description, length: { maximum: 2000 }, allow_blank: true

  searchable do
    text :cur_name
    text :cur_description

  end

  class << self
    # finds curricula based on author
    #
    # +creator+:: user object who owns curricula
    def find_curricula_for_creator(creator)
      where('curriculas.creator_id = ?', creator)
    end

    # finds curricula based on contributer
    #
    # +contributer+:: user object who does not own, but has contributed to a curricula
    def find_curricula_for_contributor(contributor)
      UserCurricula.joins(:curricula).where('user_curriculas.user_id = ? AND curriculas.creator_id != ?', contributor, contributor)
    end

    # finds curricula based on a follower
    #
    # +follower+:: user object who has followed curricula, but does not own it
    def find_curricula_for_follower(follower)
      @followed_curricula = FollowingCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', follower, follower)
    end
  end
end
