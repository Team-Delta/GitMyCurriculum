require 'spec_helper'

feature 'Visitor signs in' do
  scenario 'with valid username and password' do
    create(:user)
    sign_in_with 'bammons123', '12345678'

    expect(page).to have_content('Sign Out')
  end

  scenario 'with invalid username' do
    sign_in_with 'john', 'password'

    expect(page).to have_content('Forgot your password?')
  end

  def sign_in_with(email, password)
    visit splash_load_path
    fill_in 'email or username', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
  end
end
