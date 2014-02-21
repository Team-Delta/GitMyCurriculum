require 'spec_helper'

feature 'Visitor signs up' do
    scenario 'with valid information' do
        sign_up_with 'don', 'don@don.com', 'd0n12345', 'd0n12345'

        expect(page).to have_content('Sign Out')
        expect(page).to have_content('don')
    end

    scenario 'with invalid email' do
        sign_up_with 'name', 'name', 'l1k2j3l1k23', 'l1k2j3l1k23'

        expect(page).to have_content('Email is invalid')
    end

    scenario 'with password too short' do
        sign_up_with 'name', 'name@name.com', 'l', 'l'

        expect(page).to have_content('Password is too short (minimum is 8 characters)')
    end

    scenario 'with password not matching' do
        sign_up_with 'name', 'name@name.com', 'l124124124124', 'l125132532523'

        expect(page).to have_content('Password confirmation doesn\'t match Password')
    end

    def sign_up_with(username, email, password, password_conf)
        visit new_user_registration_path
        fill_in 'username', with: username
        fill_in 'email', with: email
        fill_in 'password', with: password
        fill_in 'password confirmation', with: password_conf

        click_button 'Submit'
    end
end
