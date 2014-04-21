require 'spec_helper'

describe DashboardController do

  describe "GET 'dashboard-main'" do
    it 'returns http success' do
      user = create(:user)
      sign_in user
      get 'show'
      response.should be_success
    end
  end

end
