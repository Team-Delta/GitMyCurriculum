require 'spec_helper'

feature 'edit_curricula' do

  background do
    create(:user)
    create(:user_2)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'project', 'some description'
  end

 
   after(:each) do
      FileUtils.rm_rf('repos/bammons123/project')
      FileUtils.rm_rf('repos/bammons123/cst314')
   end

  scenario 'edit curriculum correctly', :js => true do

    visit dashboard_dashboard_main_path
    click_link 'project'
    click_link 'Edit Curriculum'
    page.should have_css("#edit_curriculum_cur_description")

    fill_in 'edit_curriculum_cur_description', with: 'this is a thing'
    click_button 'submit'
    
    click_link 'project'
    click_link 'Edit Curriculum'
    page.should have_css("#edit_curriculum_cur_description", :text => 'this is a thing')

  end

  scenario 'add and remove a contributor correctly', :js => true do

    visit dashboard_dashboard_main_path
    click_link 'project'
    click_link 'Edit Curriculum'
    page.should have_css("#edit_curriculum_cur_description")

    fill_in 'user', with: 'tcav'
    find('#tcavalet123').click
    click_button '+'
    expect(page).to have_content('tcavalet123')

    find('#remove_tcavalet123').click
    expect(page).to have_content('No Contributors')

  end

  scenario 'test prevention of adding creator as contributor', :js => true do

    visit dashboard_dashboard_main_path
    click_link 'project'
    click_link 'Edit Curriculum'
    page.should have_css("#edit_curriculum_cur_description")

    fill_in 'user', with: 'bamm'
    find('#bammons123').click
    click_button '+'
    expect(page).to have_content('No Contributors')

  end
 
  def sign_in_with(email, password)
    visit splash_load_path
    fill_in 'email or username', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
  end

  def create_curriculum(name, description)
    visit curricula_create_path
    fill_in 'name', with: name
    fill_in 'description', with: description
    click_button 'Create'
  end

end
