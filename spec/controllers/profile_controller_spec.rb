require 'spec_helper'

describe ProfileController do

  describe "GET 'edit'" do
    it 'returns http success' do
      get 'edit'

      response.should be_success
    end
  end

  describe "GET 'load'" do
    it 'returns http success' do
      user = create(:user)
      sign_in user
      get 'load'

      response.should be_success
    end
  end
  describe "GET 'load'" do
    it 'returns http success' do
      user = create(:user_2)
      get 'load', {:username => user.username}

      response.should be_success
    end
  end
end
