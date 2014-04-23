require 'spec_helper'

feature 'Upload no zip' do
  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
  end

  scenario 'make a Curriculum' do
    system('rm -rf repos/bammons123/This')
    make_curriculum_with 'This', 'Is AWESOME'
    expect(page).to have_content('Successfully created curriculum')
  end

  def sign_in_with(email, password)
    visit splash_load_path
    fill_in 'email or username', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
  end

  def make_curriculum_with(name, description)
    visit new_curricula_path
    fill_in 'name', with: name
    fill_in 'description', with: description
    click_button 'Create'
  end

  def fake_upload_with()
   visit curricula_show_upload
   click_button 'upload'
    expect(page).to have_content ('File could not be uploaded.')
  end
end