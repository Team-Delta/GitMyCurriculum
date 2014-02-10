# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view


class SearchController < ApplicationController
  def user_search
    @search = User.search do
      fulltext params[:query]
    end
    @users = @search.results
    @numberOfMatches=@search.total
  end
end
