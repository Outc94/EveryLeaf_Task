require 'rails_helper'
RSpec.feature "Label Management Function", type: :feature do
  background do
    FactoryBot.create(:user)
    visit new_session_path
    fill_in 'email', with: 'outc@mail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    @user = User.first
    FactoryBot.create(:label, name: "label1", user_id: @user.id)
    FactoryBot.create(:label, name: "label2", user_id: @user.id)
    FactoryBot.create(:label, name: "label3", user_id: @user.id)
    FactoryBot.create(:task, title: 'Testing',
                             status: 'Not started',
                             content: 'testing the content',
                             priority:'low',
                             start_at: '2022-10-23',
                             end_at: '2029-11-12',
                             user_id: @user.id)
  end
  scenario "Test Label list" do
    visit labels_path
    save_and_open_page
    expect(page).to have_content 'label1'
  end

  scenario "Test Label Creation" do
    visit new_label_path
    fill_in 'Name', with: 'label4'
    click_button 'Save'
    expect(page).to have_content 'label4'
  end

  scenario "Test Label attached to task" do
    @task = Task.first
    @label1 = Label.first
    @label2 = Label.second
    @task.labels = [@label1, @label2]
    @task.save
    visit tasks_path
    fill_in 'search_label', with: 'label1'
    expect(page).to have_content 'label1'
  end
end
