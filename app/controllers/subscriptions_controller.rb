# Controller to manage follows/unfollows
class SubscriptionsController < ApplicationController

  def subscription
    if !params[:cur_name]
      @object_type='user'
      @user = User.find_by_username(params[:username]) if params[:username]
      @to_follow=@user.name
    else
      @object_type='curriculum'
      @curricula = Curricula.find_by cur_name: params[:curname]
      @to_follow=@curricula.cur_name
    end
    @signin=validate_login(@to_follow, params[:sub_status])
    if @signin==true
      case
      when @object_type=='user' and params[:sub_status]=='follow'
        Watching.create_follow_relationship_for current_user, @user
        flash[:success] = "You are now following #{@user.name}."
      when @object_type=='user' and params[:sub_status]=='unfollow'
        Watching.delete_follow_relationship_for current_user, @user
        flash[:success] = "You are no longer following #{@user.name}."
      when @object_type=='curriculum' and params[:sub_status]=='follow'
        FollowingCurricula.create(user_id: current_user.id, curricula_id: @curricula.id)
        flash[:success] = "You are now following #{@curricula.cur_name}."
      when @object_type=='curriculum' and params[:sub_status]=='unfollow'
        FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, @curricula.id).destroy_all
        flash[:success] = "You are no longer following #{@curricula.cur_name}."
      end
    end
    redirect_to_place(params[:redirect], params[:username], params[:query])
  end

  private

  def validate_login(name, function)
    if current_user
      @boolean = true
    else
      if function == 'unfollow'
        flash[:error] = "You must login to unfollow #{name}.".html_safe
      elsif function == 'follow'
        flash[:error] = "You must login to follow #{name}.".html_safe
      end
      @boolean = false
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
