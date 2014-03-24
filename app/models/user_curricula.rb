# Join table for users and curricula many-to-many relationship
class UserCurricula < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :curricula,  class_name: 'Curricula'

  class << self
    def get_contributors(curricula)
      UserCurricula.joins(:curricula).where('user_curriculas.user_id != curriculas.creator_id AND curricula_id = ?', curricula.id)
    end
  end
end
