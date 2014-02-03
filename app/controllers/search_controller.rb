class SearchController < ApplicationController
  def user_search
    @search = User.search do
      fulltext params[:query]
    end
    @users = @search.results
  end
end
