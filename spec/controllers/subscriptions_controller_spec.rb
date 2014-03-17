require 'spec_helper'

describe SubscriptionsController do

  describe 'user follow search', search: true do
    it 'returns user followed' do
      user = create(:user)
      sign_in user
      user_2 = create(:user_2)
      # Sunspot.commit
      # user_search - User.search { keywords 'tc' }
      # user_results=user_search.results
      # redirect_to search_s_unfollow_path(:username => u.username, :query => params[:query])
      get(:user_follow, { 'username' => user_2.username, 'redirect' =>'search' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You are now following Taylor Cavaletto.', flash[:success]
    end
  end

  describe 'user unfollow search', search: true do
    it 'returns user followed' do
      user = create(:user)
      sign_in user
      user_2 = create(:user_2)
      # Sunspot.commit
      # user_search - User.search { keywords 'tc' }
      # user_results=user_search.results
      # redirect_to search_s_unfollow_path(:username => u.username, :query => params[:query])
      get(:user_follow, { 'username' => user_2.username, 'redirect' =>'search' },  'query' => 'ta')
      get(:user_unfollow, { 'username' => user_2.username, 'redirect' =>'search' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You are no longer following Taylor Cavaletto.', flash[:success]
    end
  end

  describe 'user follow failed no current user search', search: true do
    it 'returns user followed' do
      user_2 = create(:user_2)
      # Sunspot.commit
      # user_search - User.search { keywords 'tc' }
      # user_results=user_search.results
      # redirect_to search_s_unfollow_path(:username => u.username, :query => params[:query])
      get(:user_follow, { 'username' => user_2.username, 'redirect' =>'search' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You must login to follow Taylor Cavaletto.', flash[:error]
    end
  end

  describe 'user unfollow failed no current user search', search: true do
    it 'returns user followed' do
      user_2 = create(:user_2)
      # Sunspot.commit
      # user_search - User.search { keywords 'tc' }
      # user_results=user_search.results
      # redirect_to search_s_unfollow_path(:username => u.username, :query => params[:query])
      get(:user_follow, { 'username' => user_2.username, 'redirect' =>'search' },  'query' => 'ta')
      get(:user_unfollow, { 'username' => user_2.username, 'redirect' =>'search' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You must login to unfollow Taylor Cavaletto.', flash[:error]
    end
  end
end