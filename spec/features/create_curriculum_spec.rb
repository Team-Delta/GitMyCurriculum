require 'spec_helper'

feature 'CRUD for a curriculum' do
  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
  end

  scenario 'make a Curriculum' do
    make_curriculum_with 'This', 'Is AWESOME'
    expect(page).to have_content('Successfully created curriculum')
  end

  scenario 'open a Curriculum' do
    make_curriculum_with 'This', 'Is AWESOME'
    visit authenticated_root_path
    click_link 'This'
    expect(page).to have_content('master')
  end

  scenario 'create files and save them to Curriculum' do
    make_curriculum_with 'This', 'Is AWESOME'

  end

  def clone_repository
  end
  
  def sign_in_with(email, password)
    visit splash_load_path
    fill_in 'email or username', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
  end

  def make_curriculum_with(name, description)
    visit create_curriculum_path
    fill_in 'name', with: name
    fill_in 'description', with: description
    click_button 'Create'
  end
end
