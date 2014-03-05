require 'spec_helper'

describe SearchController do

  describe "GET 'uc_search'" do
    it 'returns http success' do
      get 'uc_search'

      response.should be_success
    end
  end

  describe 'test user search', search: true do
    it 'returns the searched value' do
      user = create(:user)
      Sunspot.commit
      User.search { keywords 'Bailey' }.results.should == [user]
    end
  end

  describe 'test failed user search', search: true do
    it 'returns failed search' do
      create(:user)
      Sunspot.commit
      User.search { keywords 'fl' }.results.should == []
    end
  end

  describe 'user follow', search: true do
    it 'returns user followed' do
      user = create(:user)
      sign_in user
      #Sunspot.commit
      #user_search - User.search { keywords 'tc' }
      #user_results=user_search.results
      #redirect_to search_s_unfollow_path(:username => u.username, :query => params[:query])
      get(:s_follow, {'username' => user.username}, {'query' => 'ba'})
      assert_redirected_to search_uc_search_path
      assert_equal 'You are now following Bailey Ammons.', flash[:success]
    end
  end

  describe 'user unfollow', search: true do
    it 'returns user followed' do
      user = create(:user)
      sign_in user
      #Sunspot.commit
      #user_search - User.search { keywords 'tc' }
      #user_results=user_search.results
      #redirect_to search_s_unfollow_path(:username => u.username, :query => params[:query])
      get(:s_follow, {'username' => user.username}, {'query' => 'ba'})
      get(:s_unfollow, {'username' => user.username}, {'query' => 'ba'})
      assert_redirected_to search_uc_search_path
      assert_equal 'You are no longer following Bailey Ammons.', flash[:success]
    end
  end

end
