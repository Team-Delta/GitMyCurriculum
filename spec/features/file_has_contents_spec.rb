require 'spec_helper'

feature 'check file contents' do

  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'project', 'some description'
  end

  after(:each) do
    FileUtils.rm_rf('repos/bammons123/project')
  end

  scenario 'check to see if there is a file size and words', js: true do
    commit_push
    click_link 'project'
    click_link 'another.txt'
    expect(page).to have_content('File Size: 36bytes')
    expect(page).to have_content('8 words')
    expect(page).to have_content('This is a test. Lets hope it passes.')
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

  def commit_push
    working_repo = Git.open("#{Rails.root}/repos/bammons123/project/working/project")
    working_repo.pull
    File.open("#{Rails.root}/repos/bammons123/project/working/project/another.txt", 'w+') { |f| f.write('This is a test. Lets hope it passes.') }
    working_repo.add(all: true)
    working_repo.commit_all('Test commit')
    working_repo.push
  end

end
