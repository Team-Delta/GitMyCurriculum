require 'spec_helper'

describe DashboardController do

  describe "GET 'render'" do
    it "returns http success" do
      get 'render'
      response.should be_success
    end
  end

end
