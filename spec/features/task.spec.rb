# With this require, Capybara and other features required for Feature Spec are enabled.
require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Task management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  scenario "Test task list" do
    visit tasks_path
    expect(page).to have_content 'All Tasks'
  end

  scenario "Test task creation" do
    visit new_task_path
    fill_in 'Title', with: 'Im testing the tittle'
    fill_in 'Content', with: 'Im testing the content'
    click_button 'Save'
    save_and_open_page
    expect(page).to have_content 'Im testing the content'
  end

   scenario "Test whether tasks are arranged in descending order of creation date" do
     visit tasks_path
     assert Task.all.order('created_at desc')
   end

   scenario "Test whether tasks are ordered by deadline" do
     visit tasks_path
     click_link 'Sort by Deadline'
     save_and_open_page
     assert Task.all.order('end_at desc')
   end

   scenario "Test the search by title" do
     visit new_task_path
     fill_in 'Title', with: 'Test'
     fill_in 'Content', with: 'Testing this'
     click_button 'Save'
     visit tasks_path
     fill_in 'Search with Title', with: 'Test'
     click_button 'Search'
     expect(page).to have_content 'Testing this'
   end

   scenario "Test the search by status" do
     visit new_task_path
     fill_in 'Title', with: 'Test search'
     fill_in 'Content', with: 'Testing the status search'
     click_button 'Save'
     visit tasks_path
     fill_in 'Search with Status', with: 'Not started'
     click_button 'Search'
     expect(page).to have_content 'Not started'
   end

   scenario "Test search by both title and status" do
     visit new_task_path
     fill_in 'Title', with: 'Test title and status'
     fill_in 'Content', with: 'Testing the title and status search'
     click_button 'Save'
     visit tasks_path
     fill_in 'Search with Title', with: 'Test title and status'
     fill_in 'Search with Status', with: 'Not started'
     click_button 'Search'
     expect(page).to have_content 'Test title and status'
     expect(page).to have_content 'Not started'
   end

   scenario "Test the sort by priority" do
     visit tasks_path
     click_link 'Sort by Priority'
     save_and_open_page
     assert Task.all.order('priority desc')
   end

end
