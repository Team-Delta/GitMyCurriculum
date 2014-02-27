# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view
class SearchController < ApplicationController
  def uc_search

    @userSearch = User.search do

      if params[:query].present?
        keywords(params[:query]) do
          highlight :username
        end
      end

      #fulltext params[:query], :highlight => true
      #fulltext params[:query]
      
    end
    @users = @userSearch.results
    @numberOfUserMatches=@userSearch.total

    # @userSearch.hits.each do |hit|

    #   hit.highlights(:username) do |highlight|
    #     @users = highlight(:username).first.format { |word| "<strong>#{word}</strong>" }
    #   end
    #   hit.highlights(:name) do |highlight|
    #     @users = highlight(:name).first.format { |word| "<strong>#{word}</strong>" }
    #   end
    # end

    @currSearch = Curricula.search do
      fulltext params[:query]
    end
    @curricula = @currSearch.results
    @numberOfCurriculumMatches=@currSearch.total
  end
end
