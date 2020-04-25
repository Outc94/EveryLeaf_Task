require 'rails_helper'


RSpec.feature "User Login management", type: :feature do
  background do
    FactoryBot.create(:user, firstname: 'Mouhamed',
                             lastname: 'Diop',
                             email: 'outc@mail.com',
                             password: 'password',
                             password_confirmation: 'password')
  end
  let(:user) { FactoryBot.create(:user) }

  scenario "user registration with successful validations" do
    visit new_user_path
    user.reload
    expect(user.firstname).to eq('Mouhamed')
    expect(user.lastname).to eq('Diop')
    expect(user.email).to eq('outc@hmail.com')
  end

  scenario "successful user login and logout" do
    User.create(firstname: 'Ameth', lastname: 'Fall', email: 'ameth@gmail.com', password: 'password', password_confirmation: 'password')
    visit new_session_path
    FactoryBot.create(:user)
    fill_in 'email', with: 'ameth@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(current_path).to eq '/tasks'
    click_link 'Logout'
    expect(current_path).to eq '/sessions/new'
  end
  scenario "expect page to redirect to login when not logged in" do
    visit tasks_path
    save_and_open_page
  end

  scenario "test user creation and user list on the admin page" do
    visit admin_users_path
    save_and_open_page
    expect(page).to have_content 'Mouhamed'
  end

end
