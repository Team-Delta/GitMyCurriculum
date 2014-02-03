require 'spec_helper'

describe SearchController do

  describe "GET 'user_search'" do
    it "returns http success" do
      get 'user_search'
      response.should be_success
    end
  end

end
