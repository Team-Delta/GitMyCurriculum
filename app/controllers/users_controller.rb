# controller for users
class UsersController < ApplicationController
  # loads all of the related information of any user
  def show
    @user = User.find_by_username(params[:username])
    @peers = @user.peers
    @month = Date::MONTHNAMES[@user.created_at.month]
    @year = @user.created_at.year
    @day = @user.created_at.day
    @created_curricula = Curricula.find_curricula_for_creator current_user
    @contributed_curricula = Curricula.find_curricula_for_contributor current_user
    @followed_curricula = Curricula.find_curricula_for_follower current_user
    @is_peer = Watching.find_peers_for current_user, @user
  end
end
