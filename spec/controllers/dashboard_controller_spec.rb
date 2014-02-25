require 'spec_helper'

describe DashboardController do

  describe "GET 'dashboard-main'" do
    it 'returns http success' do
      user = create(:user)
      sign_in user
      get 'dashboard_main'
      response.should be_success
    end
  end

end
