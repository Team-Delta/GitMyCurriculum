# controller for users
class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @peers = @user.peers
    @month = Date::MONTHNAMES[@user.created_at.month]
    @year = @user.created_at.year
    @day = @user.created_at.day
    @created_curricula = Curricula.find_curricula_for_creator current_user
    @contributed_curricula = Curricula.find_curricula_for_contributor current_user
    @is_peer = Watching.find_peers_for current_user, @user
    #@is_peer = Watching.where('user_id=? AND peer_id=?', current_user.id, @user.id) if current_user
  end

  def follow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.create_follow_relationship_for current_user, @user
      flash[:success] = "You are now following #{@user.name}."
    else
      flash[:error] = "You must login to follow #{@user.name}.".html_safe
    end
    redirect_to users_show_path(username: @user.username)
  end

  def unfollow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.delete_follow_relationship_for current_user, @user
      flash[:success] = "You are no longer following #{@user.name}."
    else
      flash[:error] = "You must login to unfollow #{@user.name}.".html_safe
    end
    redirect_to users_show_path(username: @user.username)
  end
end
