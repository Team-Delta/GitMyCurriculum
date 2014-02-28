# Performs search query based on query strings entered in the search field
# Create instance variable @search set to the return of the query
# Set instance variable @users to the results and render @users in the view
class SearchController < ApplicationController
  def uc_search
    @user_search = User.search do

      if params[:query].present?
        keywords(params[:query]) do
          highlight :username
        end
      end

      # fulltext params[:query], :highlight => true
      # fulltext params[:query]

    end
    @users = @user_search.results
    @number_of_user_matches = @user_search.total

    # @userSearch.hits.each do |hit|

    #   hit.highlights(:username) do |highlight|
    #     @users = highlight(:username).first.format { |word| "<strong>#{word}</strong>" }
    #   end
    #   hit.highlights(:name) do |highlight|
    #     @users = highlight(:name).first.format { |word| "<strong>#{word}</strong>" }
    #   end
    # end

    @curr_search = Curricula.search do
      fulltext params[:query]
    end
    @curricula = @curr_search.results
    @number_of_curriculum_matches = @curr_search.total
  end
end
