require 'spec_helper'

describe SearchController do

  describe "GET 'user_search'" do
    it 'returns http success' do
      get 'user_search'

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
end
