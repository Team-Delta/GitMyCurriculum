# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view
class SearchController < ApplicationController
  def uc_search
    @all_search = Sunspot.search(User, Curricula) do
      fulltext params[:query] do
        boost_fields username: 2.0
        boost_fields cur_name: 2.0
      end
    end

    @allresults = @all_search.results

    @user_search = User.search do
      fulltext params[:query] do
        boost_fields username: 2.0
      end
    end

    @users = @user_search.results
    @number_of_user_matches = @user_search.total

    @curr_search = Curricula.search do
      fulltext params[:query] do
        boost_fields cur_name: 2.0
      end
    end

    @curricula = @curr_search.results
    @number_of_curriculum_matches = @curr_search.total
  end

  def s_follow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.create_follow_relationship_for current_user, @user
      flash[:success] = "You are now following #{@user.name}."
    else
      flash[:error] = "You must login to follow #{@user.name}.".html_safe
    end
    redirect_to search_uc_search_path(query: params[:query])
  end

  def s_unfollow
    @user = User.find_by_username(params[:username])
    if current_user
      Watching.delete_follow_relationship_for current_user, @user
      flash[:success] = "You are no longer following #{@user.name}."
    else
      flash[:error] = "You must login to unfollow #{@user.name}.".html_safe
    end
    redirect_to search_uc_search_path(query: params[:query])
  end
end
