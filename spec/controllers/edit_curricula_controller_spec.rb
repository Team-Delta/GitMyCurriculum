require 'spec_helper'

describe EditCurriculaController do

  describe "GET 'edit'" do
    it 'returns http success' do
      cur = create(:curricula)
      user = create(:user)
      sign_in user
      get 'edit',{:id => cur.id}
      response.should be_success
    end
  end
end
