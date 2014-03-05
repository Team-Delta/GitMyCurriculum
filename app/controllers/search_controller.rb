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
end
