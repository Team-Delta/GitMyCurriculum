# Controller to manage follows/unfollows
class SubscriptionsController < ApplicationController
  def subscription
    @user = User.find_by_username(params[:username]) if params[:username]
    if !params[:cur_id]
      @to_follow = @user.name
    else
      @curricula = Curricula.find(params[:cur_id])
      @to_follow = @curricula.cur_name
    end

    set_relation(params[:sub_status], @curricula, @user) if validate_login(@to_follow, params[:sub_status])

    redirect_to_place(params[:redirect], params[:username], params[:query], params[:tab], params[:cur_id])
  end

  private

  def set_relation(substatus, curricula, user)
    case substatus
    when 'user_follow'
      Watching.create_follow_relationship_for current_user, user
      flash[:success] = "You are now following #{user.name}."
    when 'user_unfollow'
      Watching.delete_follow_relationship_for current_user, user
      flash[:success] = "You are no longer following #{user.name}."
    when 'curricula_follow'
      FollowingCurricula.create(user_id: current_user.id, curricula_id: curricula.id)
      flash[:success] = "You are now following #{curricula.cur_name}."
    when 'curricula_unfollow'
      FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, curricula.id).destroy_all
      flash[:success] = "You are no longer following #{curricula.cur_name}."
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
      flash[:error] = "You must login to follow or unfollow #{name}.".html_safe
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
  def redirect_to_place(redirect, username, query, tab, id)
    case redirect
    when 'dashboard'
      redirect_to dashboard_dashboard_main_path
    when 'profile'
      redirect_to profile_load_path(username: username, tab: tab)
    when 'search'
      redirect_to search_uc_search_path(query: query)
    when 'curricula'
      redirect_to curricula_path(id: id)
    end
  end
end
