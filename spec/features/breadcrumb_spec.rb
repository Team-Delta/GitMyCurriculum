require 'spec_helper'

feature 'Breadcrumb' do

  background do
     create(:user)
     sign_in_with 'bammons123', '12345678'
     create_curriculum 'project', 'some description'
   end

  after(:each) do
    FileUtils.rm_rf('repos/bammons123/project')
  end

  scenario 'click file, added to breadcrumb', js: true do
    click_link 'project'
    click_link 'testfile.doc'
    page.should have_css('#breadcrumb', text: 'testfile.doc')
  end

  scenario 'click folder, added to breadcrumb', js: true do
    commit_push
    click_link 'project'
    click_link 'someFolder'
    page.should have_css('#breadcrumb', text: 'someFolder')
  end

  scenario 'click breadcrumb curriculum link', js: true do
    visit dashboard_dashboard_main_path
    click_link 'project'
    click_link 'testfile.doc'
    page.should have_css('#breadcrumb', text: 'testfile.doc')
    click_link 'project'
    page.should have_no_css('#breadcrumb', text: 'testfile.doc')
  end

  def commit_push
    working_repo = Git.open("#{Rails.root}/repos/bammons123/project/working/project")
    working_repo.pull
    Dir.mkdir("#{Rails.root}/repos/bammons123/project/working/project/someFolder")
    File.open("#{Rails.root}/repos/bammons123/project/working/project/someFolder/another.txt", 'w+') { |f| f.write('Temporary document: can be deleted.') }
    working_repo.add(all: true)
    working_repo.commit_all('second commit')
    working_repo.push
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
