# Controller to manage follows/unfollows
class SubscriptionsController < ApplicationController
  def subscription
    if !params[:cur_name]
      @object_type = 'user'
      @user = User.find_by_username(params[:username]) if params[:username]
      @to_follow = @user.name
    else
      @object_type = 'curriculum'
      @curricula = Curricula.find_by cur_name: params[:cur_name]
      @to_follow = @curricula.cur_name
    end
    @signin = validate_login(@to_follow, params[:sub_status])

    set_relation(params[:sub_status], @curricula, @user, @object_type) if @signin

    redirect_to_place(params[:redirect], params[:username], params[:query], params[:tab])
  end

  private

  def set_relation(substatus, curricula, user, type)
    case
    when type == 'user'
      if substatus == 'follow'
        Watching.create_follow_relationship_for current_user, user
        flash[:success] = "You are now following #{user.name}."
      else
        Watching.delete_follow_relationship_for current_user, @user
        flash[:success] = "You are no longer following #{user.name}."
      end
    when type == 'curriculum'
      if substatus == 'follow'
        FollowingCurricula.create(user_id: current_user.id, curricula_id: curricula.id)
        flash[:success] = "You are now following #{curricula.cur_name}."
      else
        FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, curricula.id).destroy_all
        flash[:success] = "You are no longer following #{curricula.cur_name}."
      end
    end
  end

  private

  # validates user's login state when attempting to follow or unfollow a user
  # +name+:: of the user attempting to subscribe
  # +function+:: either "follow" or "unfollow"
  def validate_login(name, function)
    if current_user
      @boolean = true
    else
      flash[:error] = "You must login to #{function} #{name}.".html_safe
      @boolean = false
    end
    @boolean
  end

  # redirects based user to
  # +redirect+:: redirects user to either
  # * "dashboard: shows the dashboard
  # * "profile" shows current user profile, following view
  # * "search" shows a search based on a "query"
  # * "user_curricula" shows a list curriculum for a specific "username"
  # * "user_info" shows the info of a specific "username"
  def redirect_to_place(redirect, username, query, tab)
    case redirect
    when 'dashboard'
      redirect_to dashboard_dashboard_main_path
    when 'profile'
      redirect_to profile_load_path(username: username, tab: tab)
    when 'search'
      redirect_to search_uc_search_path(query: query)
    end
  end
end
