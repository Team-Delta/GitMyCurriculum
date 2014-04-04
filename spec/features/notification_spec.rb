require 'spec_helper'

feature 'notification tests' do

  background do
    @user = create(:user)
    @user2 = create(:user_2)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'project', 'some description'
  end

  after(:each) do
    FileUtils.rm_rf('repos/bammons123/project')
  end

  scenario 'forking should create notification', js: true do
    click_link 'project'
    click_link 'Edit Curriculum'
    fill_in 'user', with: 'tcav'
    find('#tcavalet123').click
    click_button '+'
    expect(page).to have_content('tcavalet123')
    click_link 'Sign Out'
    sign_in_with 'tcavalet123', '12345678'
    click_link 'project'
    click_link 'Fork'
    click_link 'Sign Out'
    sign_in_with 'bammons123', '12345678'
    expect(page).to have_content('tcavalet123 has forked bammons123/project')
    FileUtils.rm_rf('repos/tcavalet123')
  end

  scenario 'deleting a save should create notification' do
    commit_push
    click_link 'project'
    click_link 'Change History'
    first(:link, 'Delete Save').click
    visit dashboard_dashboard_main_path
    expect(page).to have_content('bammons123 has deleted a save on bammons123/project')
  end

  scenario 'making commit should create notification' do
    commit_push
    visit dashboard_dashboard_main_path
    expect(page).to have_content('bammons123 has saved to stream master on bammons123/project')
  end

  def commit_push
    working_repo = Git.open("#{Rails.root}/repos/bammons123/project/working/project")
    working_repo.pull
    File.open("#{Rails.root}/repos/bammons123/project/working/project/another.txt", 'w+') { |f| f.write('Temporary document: can be deleted.') }
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
