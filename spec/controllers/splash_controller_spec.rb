require 'spec_helper'

describe SplashController do

    describe "GET 'load'" do
        it 'returns http success' do
            get 'load'

            response.should be_success
        end
    end

end
