require 'spec_helper'

feature 'Forking' do

  before(:each) do
    create(:user)
    create(:user_2)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'project', 'some description'
  end

  after(:each) do
    FileUtils.rm_rf('repos/bammons123/project')
    FileUtils.rm_rf('repos/tcavalet123/project')
  end

  scenario 'fork a curriculum', js: true do
    click_link 'project'
    click_link 'Settings'
    fill_in 'user', with: 'tcav'
    find('#tcavalet123').click
    click_button '+'
    expect(page).to have_content('tcavalet123')
    click_link 'Sign Out'
    sign_in_with 'tcavalet123', '12345678'
    within('#contributed-curricula') do
      click_link 'project'
    end
    click_link 'Fork'
    within('#created-curricula') do
      click_link 'project'
    end
    expect(page).to have_content('forkfile.doc')
  end

  def sign_in_with(email, password)
    visit splash_load_path
    fill_in 'email or username', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
  end

  def create_curriculum(name, description)
    visit new_curricula_path
    fill_in 'name', with: name
    fill_in 'description', with: description
    click_button 'Create'
  end

end
