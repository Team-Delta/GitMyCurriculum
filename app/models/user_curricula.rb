# Join table for users and curricula many-to-many relationship
class UserCurricula < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :curricula,  class_name: 'Curricula'

  class << self
    def get_contributors(curricula)
      UserCurricula.joins(:curricula).where('user_curriculas.user_id != curriculas.creator_id AND curricula_id = ?', curricula.id).includes(:user)
    end

    def clear_contributors(curricula)
      UserCurricula.where('curricula_id=?', curricula.id).destroy_all
    end

    def remove_contributor(curricula, user)
      UserCurricula.where('curricula_id=? AND user_id=?', curricula.id, user.id).destroy_all
    end

    def does_user_exist(curricula, id)
      UserCurricula.where('curricula_id=? AND user_id=?', curricula.id, id).first
    end
  end
end
