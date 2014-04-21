require 'spec_helper'

feature 'Save comparison' do

  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
    create_curriculum 'comparison', 'some description'
  end

  after(:each) do
    FileUtils.rm_rf('repos/bammons123/comparison')
  end

  scenario 'new file is present' do
    commit_push
    click_link 'comparison'
    click_link 'Change History'
    click_link 'second commit'
    expect(page).to have_content('This is a new file.')
  end

  scenario 'File difference check ' do
    visit dashboard_show_path
    commit_push
    click_link 'comparison'
    click_link 'Change History'
    click_link 'second commit'
    page.should have_css('.del', text: 'Temporary document: can be deleted.')
    page.should have_css('.ins', text: 'New content.')
  end

  def commit_push
    working_repo = Git.open("#{Rails.root}/repos/bammons123/comparison/working/comparison")
    working_repo.pull
    File.open("#{Rails.root}/repos/bammons123/comparison/working/comparison/another.txt", 'w+') { |f| f.write('This is a new file.') }
    File.open("#{Rails.root}/repos/bammons123/comparison/working/comparison/testfile.doc", 'w+') { |f| f.write('New content.') }
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
    visit new_curricula_path
    fill_in 'name', with: name
    fill_in 'description', with: description
    click_button 'Create'
  end

end
