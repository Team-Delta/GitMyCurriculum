# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view
class SearchController < ApplicationController
  def uc_search
    @user_search = User.search do
      fulltext params[:query]
    end

    @users = @user_search.results
    @number_of_user_matches = @user_search.total

    @curr_search = Curricula.search do
      fulltext params[:query]
    end

    @curricula = @curr_search.results
    @number_of_curriculum_matches = @curr_search.total
  end

  def s_follow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.create(user_id: current_user.id, peer_id: @user.id)
      flash[:success] = "You are now following #{@user.name}."
    else
      flash[:error] = "You must login to follow #{@user.name}.".html_safe
    end
    redirect_to search_uc_search_path(query: params[:query])
  end

  def s_unfollow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.where('user_id=? AND peer_id=?', current_user.id, @user.id).destroy_all
      flash[:success] = "You are no longer following #{@user.name}."
    else
      flash[:error] = "You must login to unfollow #{@user.name}.".html_safe
    end
    redirect_to search_uc_search_path(query: params[:query])
  end

  def s_c_follow
    @curricula = Curricula.find_by cur_name: params[:curname]
    if current_user
      FollowingCurricula.create(user_id: current_user.id, curricula_id: @curricula.id)
      flash[:success] = "You are now following #{@curricula.cur_name}."
    else
      flash[:error] = "You must login to follow #{@curricula.cur_name}.".html_safe
    end
    redirect_to search_uc_search_path(query: params[:query])
  end

  def s_c_unfollow
    @curricula = Curricula.find_by cur_name: params[:curname]
    if current_user
      FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, @curricula.id).destroy_all
      flash[:success] = "You are no longer following #{@curricula.cur_name}."
    else
      flash[:error] = "You must login to unfollow #{@curricula.cur_name}.".html_safe
    end
    redirect_to search_uc_search_path(query: params[:query])
  end
end
