require 'spec_helper'

describe ProfileController do

  describe "GET 'edit'" do
    it 'returns http success' do
      get 'edit'

      response.should be_success
    end
  end

  # describe "GET 'create'"do
  #   it 'returns http success' do
  #      @info = {:description => 'post_params', :occupation => 'post_params'}
  #     get 'create'
  #     response should be_success
  #     #@info.occupation.should eql nil
  #   end
  # end
end
