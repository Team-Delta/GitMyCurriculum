# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view
class SearchController < ApplicationController
  def uc_search

    @userSearch = User.search do
      fulltext params[:query]
    end
    @users = @userSearch.results
    @numberOfUserMatches=@userSearch.total

    @currSearch = Curricula.search do
      fulltext params[:query]
    end
    @curricula = @currSearch.results
    @numberOfCurriculumMatches=@currSearch.total
  end
end
