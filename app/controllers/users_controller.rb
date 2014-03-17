# controller for users
class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @peers = @user.peers
    @created_curricula = Curricula.where('creator_id = ?', @user.id)
    @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', @user.id, @user.id)
    @is_peer = Watching.where('user_id=? AND peer_id=?', current_user.id, @user.id) if current_user
  end

  def follow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.create(user_id: current_user.id, peer_id: @user.id)
      flash[:success] = "You are now following #{@user.name}."
    else
      flash[:error] = "You must login to follow #{@user.name}.".html_safe
    end
    redirect_to users_show_path(username: @user.username)
  end

  def unfollow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.where('user_id=? AND peer_id=?', current_user.id, @user.id).destroy_all
      flash[:success] = "You are no longer following #{@user.name}."
    else
      flash[:error] = "You must login to unfollow #{@user.name}.".html_safe
    end
    redirect_to users_show_path(username: @user.username)
  end

  def c_follow
    @curricula = Curricula.find_by cur_name: params[:curname]
    if current_user
      FollowingCurricula.create(user_id: current_user.id, curricula_id: @curricula.id)
      flash[:success] = "You are now following #{@curricula.cur_name}."
    else
      flash[:error] = "You must login to follow #{@curricula.cur_name}.".html_safe
    end
    redirect_to users_show_path(username: params[:username], tab: 'curricula')
  end

  def c_unfollow
    @curricula = Curricula.find_by cur_name: params[:curname]
    if current_user
      FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, @curricula.id).destroy_all
      flash[:success] = "You are no longer following #{@curricula.cur_name}."
    else
      flash[:error] = "You must login to unfollow #{@curricula.cur_name}.".html_safe
    end
    redirect_to users_show_path(username: params[:username], tab: 'curricula')
  end
end
