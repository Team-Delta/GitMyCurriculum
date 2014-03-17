# Controller to manage follows/unfollows
class SubscriptionsController < ApplicationController
  def user_follow
    @user = User.find_by_username(params[:username])
    @signin = validate_login(@user.name, 'follow')
    if @signin == 'true'
      Watching.create_follow_relationship_for current_user, @user
      flash[:success] = "You are now following #{@user.name}."
    end
    redirect_to_place(params[:redirect], params[:username], params[:query])
  end

  def user_unfollow
    @user = User.find_by_username(params[:username])
    @signin = validate_login(@user.name, 'unfollow')
    if @signin == 'true'
      Watching.delete_follow_relationship_for current_user, @user
      flash[:success] = "You are no longer following #{@user.name}."
    end
    redirect_to_place(params[:redirect], params[:username], params[:query])
  end

  def curricula_follow
    @curricula = Curricula.find_by cur_name: params[:curname]
    @signin = validate_login(params[:curname], 'follow')
    if @signin == 'true'
      FollowingCurricula.create(user_id: current_user.id, curricula_id: @curricula.id)
      flash[:success] = "You are now following #{@curricula.cur_name}."
    end
    redirect_to_place(params[:redirect], params[:username], params[:query])
  end

  def curricula_unfollow
    @curricula = Curricula.find_by cur_name: params[:curname]
    @signin = validate_login(params[:curname], 'unfollow')
    if @signin == 'true'
      FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, @curricula.id).destroy_all
      flash[:success] = "You are no longer following #{@curricula.cur_name}."
    end
    redirect_to_place(params[:redirect], params[:username], params[:query])
  end

  private

  def validate_login(name, function)
    if current_user
      @boolean = 'true'
    else
      if function == 'unfollow'
        flash[:error] = "You must login to unfollow #{name}.".html_safe
      elsif function == 'follow'
        flash[:error] = "You must login to follow #{name}.".html_safe
      end
      @boolean = 'false'
    end
    @boolean
  end

  def redirect_to_place(redirect, username, query)
    case redirect
    when 'dashboard'
      redirect_to dashboard_dashboard_main_path
    when 'profile'
      redirect_to profile_load_path(tab: 'following')
    when 'search'
      redirect_to search_uc_search_path(query: query)
    when 'user_curricula'
      redirect_to users_show_path(username: username, tab: 'curricula')
    when'user_info'
      redirect_to users_show_path(username: username, tab: 'info')
    end
  end
end
