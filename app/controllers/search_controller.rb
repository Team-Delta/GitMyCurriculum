# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view
class SearchController < ApplicationController
  # takes in a search string as "query" get param
  # and returns a page of similar users and curricula
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
end
