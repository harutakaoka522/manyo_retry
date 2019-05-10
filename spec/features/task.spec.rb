require 'rails_helper.rb'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest', end_limit: '1', status: 'a', priority: 'b')
    Task.create!(title: 'test_task_02', content: 'samplesample', end_limit: '1', status: 'a', priority: 'b')
  
    visit tasks_path

    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
  visit new_task_path

   fill_in 'task_title', with: 'test_task_01'
   fill_in 'task_content', with: 'testtesttest'
   fill_in 'task_end_limit', with: '1'
   fill_in 'task_status', with: 'a'
   fill_in 'task_priority', with: 'b'

  click_on 'Create Task'

  expect(page).to have_content 'test_task_01'
  expect(page).to have_content 'testtesttest'
end

  scenario "タスク詳細のテスト" do
    visit new_task_path
    task = Task.create!(title: 'test_task_01', content: 'testtesttest', end_limit: '1', status: 'a', priority: 'b')

    click_on 'Create Task'
    
    visit task_path(task.id)

    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end
end