require 'spec_helper'

feature 'add sources' do

  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'project', 'some description'
  end
 
   after(:each) do
      FileUtils.rm_rf('repos/bammons123/project')
   end

  scenario 'make a new source correctly', :js => true do
    click_link 'project'
    click_link 'Sources'
    sleep(2.0)
    make_source_with 'http://getbootstrap.com/css/#top', 'This is awesome'
    sleep(2.0)
    expect(page).to have_content('Success')
    expect(page).to have_content('This is awesome')
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

  def make_source_with(url_for_source, tag_for_source)
    visit source_show_path(1)
    fill_in 'url for source', with: url_for_source
    fill_in 'tag for source', with: tag_for_source
    click_button 'add source'
  end

end
