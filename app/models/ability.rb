# this has the abilitys defined for what a user can do with the gem cancan
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :update, Curricula do |curricula|
      UserCurricula.does_user_exist(curricula, user.id).blank? == false || curricula.creator.id == user.id
    end

    can :update, user
    can :read, :all
  end
end
