require 'spec_helper'

feature 'Edit profile' do
  background do
    create(:user)
    sign_in_with 'bammons123', '12345678'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'with valid information' do
    edit_profile_with 'lestewar', 'lefa@gmail.com', '12345678', '12345678', '12345678'

    expect(page).to have_content('You updated your account successfully.')
  end

  scenario 'incorrect change password' do
    edit_profile_with 'lestewar', 'lefa@gmail.com', '12345678', '123456789', '12345678'
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end

  def sign_in_with(email, password)
    visit splash_load_path
    fill_in 'email or username', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
  end

  def edit_profile_with(username, email, password, new_password, new_password_conf)
    visit('/users/edit')
    fill_in 'username', with: username
    fill_in 'email', with: email
    fill_in 'current password', with: password
    fill_in 'new password', with: new_password
    fill_in 'new password confirmation', with: new_password_conf

    click_button 'Submit'
  end
end
