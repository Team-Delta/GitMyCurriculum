require 'spec_helper'


feature 'Visitor searches' do
  #scenario ' for username in database' do
  #  create(:user)
  #  search_for 'bammons123'
  #
  #  expect(page).to have_content('bammons123')
  #end

  scenario ' for username not in database' do
    search_for 'bammons'

    expect(page).to have_content('No Match Found')
  end

  def search_for(username)
    visit splash_load_path
    fill_in 'Search!', with: username
    visit search_user_search_path
  end
end