require 'spec_helper'

describe Curricula::SettingsController do

  describe "GET 'show'" do
    it 'returns http success' do
      cur = create(:curricula)
      user = create(:user)
      sign_in user
      get 'show', id: cur.id
      response.should be_success
    end
  end
end
