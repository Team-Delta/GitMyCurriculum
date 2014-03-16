# controller for users
class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @peers = @user.peers
    @month = @user.created_at.month
    @year = @user.created_at.year
    @day = @user.created_at.day
    @created_curricula = Curricula.where('creator_id = ?', @user.id)
    @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', @user.id, @user.id)
    @is_peer = Watching.where('user_id=? AND peer_id=?', current_user.id, @user.id) if current_user
    case @month
    when 1
      @month = 'January'
    when 2
      @month = 'February'
    when 3
      @month = 'March'
    when 4
      @month = 'April'
    when 5
      @month = 'May'
    when 6
      @month = 'June'
    when 7
      @month = 'July'
    when 8
      @month = 'August'
    when 9
      @month = 'September'
    when 10
      @month = 'October'
    when 11
      @month = 'November'
    when 12
      @month = 'December'
    end
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
end
