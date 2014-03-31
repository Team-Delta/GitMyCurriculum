require 'spec_helper'

feature 'Revert Save' do

  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'revert', 'some description'
  end

  after(:each) do
    FileUtils.rm_rf('repos/bammons123/revert')
  end

  scenario 'fail to revert initial commit' do
    click_link 'revert'
    click_link 'Change History'
    click_link 'Delete Save'
    expect(page).to have_content('It appears that save has no parents.')
  end

  scenario 'successful deletion of a commit' do
    visit dashboard_dashboard_main_path
    commit_push
    click_link 'revert'
    click_link 'Change History'
    first(:link, 'Delete Save').click
    expect(page).to have_no_content('second commit')
  end

  def commit_push
    working_repo = Git.open("#{Rails.root}/repos/bammons123/revert/working/revert")
    working_repo.pull
    File.open("#{Rails.root}/repos/bammons123/revert/working/revert/another.txt", 'w+') { |f| f.write('Temporary document: can be deleted.') }
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
