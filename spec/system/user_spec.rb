require 'rails_helper'
RSpec.describe 'User registration / login / logout function', type: :system do
  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'user@gmail.com'
    fill_in 'session[password]', with: '00000000'
    click_button 'Sign in'
  end

  def admin_user_login
    visit new_session_path
    fill_in 'session[email]', with: 'admin@gmail.com'
    fill_in 'session[password]', with: '99999999'
    click_button 'Sign in'
  end


  describe 'User registration test' do
    context 'No user data and no login' do
      it 'The new user can be registred.' do
        visit new_user_path
        fill_in 'user[name]', with: 'example'
        fill_in 'user[email]', with: 'user@example.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_on "Sign up"
        expect(page).to have_content 'Tasks'
      end
      it 'Test for jumping to the login screen when you are not logged in.' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'Session functionality testing' do
    before do
      @user = FactoryBot.create(:user)
      user_login
    end

    context 'If you have user data while you are not logged in.' do
      it 'Being able to log in' do
        expect(page).to have_content 'There is no task created by this user'
      end
    end

    context 'Log in as general user.' do
      it 'You can jump to your own details screen' do
        click_link 'Ma page'
         expect(current_path).to eq user_path(1)
      end

      it 'Test for displayed task list ouce the general user jump to the details screen of another person.' do
        visit user_path(2)
        expect(current_path).to eq tasks_path
      end

      it 'Being able to log out' do
        click_link 'Log out'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'Management screen test' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end

    context 'Log in as a general user' do
      it 'General users cannot access the management screen' do
        user_login
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
    end

    context 'You are logged in as an administrator' do
      before do
        admin_user_login
        click_link 'Management'
      end

      it 'Administrators should be able to access the management screen' do
        expect(current_path).to eq admin_users_path
      end

      it 'Administrators can register new users' do
        click_link 'New user registration'
        fill_in 'user[name]', with: 'adminpower'
        fill_in 'user[email]', with: 'adminpower@gmail.com'
        fill_in 'user[password]', with: '654321'
        fill_in 'user[password_confirmation]', with: '654321'
        click_button "Register"
        visit admin_users_path
        expect(page).to have_content 'adminpower'
      end

      it 'The administrator should have access to the user\'s details screen' do
        click_link 'admin'
        expect(current_path).to eq user_path(2)
      end

      it 'The administrator can edit the user from the user edit screen' do
        click_link 'Edit/Delete', href: edit_admin_user_path(1)
        fill_in 'user[name]', with: 'user'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button "Approve"
          sleep 1
        expect(page).to have_content 'user'
      end

      it 'Administrators can delete users' do
        click_link 'Edit/Delete', href: edit_admin_user_path(1)
        click_link 'Delete user data'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "test"
      end
    end
 end
end
