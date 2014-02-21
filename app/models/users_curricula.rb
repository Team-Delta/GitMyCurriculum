# create_table 'users_curriculas', force: true do |t|
#   t.integer  'user_id',                                null: false
#   t.integer  'curricula_id',                           null: false
#   t.integer  'curricula_permission_level', default: 0, null: false
#   t.datetime 'created_at',                             null: false
#   t.datetime 'updated_at',                             null: false
# end
class UsersCurricula < ActiveRecord::Base
  attr_accessible :user, :user_id, :curricula_permission_level

  belongs_to :user
  belongs_to :curricula

  validates :user, presence: true
  validates :user_id, uniqueness: { scope: [:curricula_id], message: 'user already in curriculum' }
  validates :curricula, presence: true

  delagate :name, :username, :email, to: :user, prefix: true

  scope :in_curricula, ->(curricula) { where(curricula_id: curricula.id) }
  scope :in_curriculas, ->(curriculas) { where(curricula_id: curricula.map { |p| p.id }) }
  scope :with_user, ->(user) { where(user_id: user.id) }

  class << self
    # add users to curricula
    def add_users_to_curriculas(curricula_ids, user_ids)
      UsersCurricula.transaction do
        curricula_ids.each do |curricula_id|
          user_ids.each do |user_id|
            users_curricula = UsersCurricula.new(user_id: user_id)
            users_curricula.curricula_id = curricula_id
            users_curricula.save
          end
        end
      end
    end
  end
end
