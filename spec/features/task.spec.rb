# With this require, Capybara and other features required for Feature Spec are enabled.
require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Task management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  scenario "Test task list" do
    visit tasks_path
    expect(page).to have_content 'Tasks'
  end

  scenario "Test task creation" do
    visit new_task_path
    fill_in 'Title', with: 'Im testing the tittle'
    fill_in 'Content', with: 'Im testing the content'
    click_button 'Create Task'
    save_and_open_page
    expect(page).to have_content 'Im testing the content'
  end

  scenario "Test task details" do
    visit new_task_path
    fill_in 'Title', with: 'Im testing the tittle'
    fill_in 'Content', with: 'Im testing again the content'
    click_on 'Create Task'
    click_on 'Return'
    click_on 'Show'
    expect(page).to have_text 'Im testing again the content'
  end

   scenario "Test whether tasks are arranged in descending order of creation date" do
     Task.all.order('created_at desc')
     visit tasks_path
   end

end
