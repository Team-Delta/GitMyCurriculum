require 'spec_helper'

describe SubscriptionsController do

  describe 'user follow search', search: true do
    it 'returns user followed' do
      user = create(:user)
      sign_in user
      user_2 = create(:user_2)
      get(:subscription, { 'username' => user_2.username, 'redirect' => 'search', 'sub_status' => 'user_follow' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You are now following Taylor Cavaletto.', flash[:success]
    end
  end

  describe 'user unfollow search', search: true do
    it 'returns user unfollowed' do
      user = create(:user)
      sign_in user
      user_2 = create(:user_2)
      get(:subscription, { 'username' => user_2.username, 'redirect' => 'search', 'sub_status' => 'user_follow' },  'query' => 'ta')
      get(:subscription, { 'username' => user_2.username, 'redirect' => 'search', 'sub_status' => 'user_unfollow' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You are no longer following Taylor Cavaletto.', flash[:success]
    end
  end

  describe 'curriculum_follow_search', search: true do
    it 'returns with curriculum followed' do
      user = create(:user)
      sign_in user
      cur = create(:curricula)
      get(:subscription, {'cur_id' => cur.id, 'redirect' => 'search', 'sub_status' => 'curricula_follow'}, 'query' => 'te')
      assert_redirected_to search_uc_search_path
      assert_equal 'You are now following test-curriculum.', flash[:success]
    end
  end

  describe 'curricula_unfollow_search', search: true do
    it 'returns with curriculum unfollowed' do
      user = create(:user)
      sign_in user
      cur = create(:curricula)
      get(:subscription, {'cur_id' => cur.id, 'redirect' => 'search', 'sub_status' => 'curricula_follow'}, 'query' => 'te')
      get(:subscription, { 'cur_id' => cur.id, 'redirect' => 'search', 'sub_status' => 'curricula_unfollow' },  'query' => 'te')
      assert_redirected_to search_uc_search_path
      assert_equal 'You are no longer following test-curriculum.', flash[:success]
    end
  end

  describe 'user follow failed no current user search', search: true do
    it 'returns user followed' do
      user_2 = create(:user_2)
      get(:subscription, { 'username' => user_2.username, 'redirect' => 'search', 'sub_status' => 'user_follow' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You must login to follow or unfollow Taylor Cavaletto.', flash[:error]
    end
  end

  describe 'user unfollow failed no current user search', search: true do
    it 'returns user followed' do
      user_2 = create(:user_2)
      get(:subscription, { 'username' => user_2.username, 'redirect' => 'search', 'sub_status' => 'user_follow' },  'query' => 'ta')
      get(:subscription, { 'username' => user_2.username, 'redirect' => 'search', 'sub_status' => 'user_unfollow' },  'query' => 'ta')
      assert_redirected_to search_uc_search_path
      assert_equal 'You must login to follow or unfollow Taylor Cavaletto.', flash[:error]
    end
  end
end
