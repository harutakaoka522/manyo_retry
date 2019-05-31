require 'rails_helper.rb'

RSpec.feature "タスク管理機能", type: :feature do

 before do
  @user = User.create(name: 'test', email: 'aaa@gmail.com', password: 'password',password_confirmation: 'password')
  visit new_session_path
 
  fill_in 'session[email]', with: @user.email 
  fill_in 'session[password]', with: 'password' 
  click_on "Log in"

  Task.create!(title: 'test_task_01', content: 'testtesttest', end_limit: '2019-12-25', status: '未着手', priority: '高', user_id: @user.id)
  Task.create!(title: 'test_task_02', content: 'samplesample', end_limit: '2019-06-25', status: '完了', priority: '低', user_id: @user.id)
  visit tasks_path    
end


scenario "タスク一覧のテスト" do
  visit tasks_path

  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'samplesample'
end

scenario "タスク作成のテスト" do
  visit new_task_path
  
  fill_in 'task_title', with: 'test_task_01'
  fill_in 'task_content', with: 'testtesttest'
  fill_in 'task_end_limit', with: '2019-06-31'
  select '未着手', from: 'task_status'
  select '高', from: 'task_priority'
   
  click_on '登録する'
  save_and_open_page
  expect(page).to have_content 'test_task_01'
  expect(page).to have_content 'testtesttest'
end

scenario "タスク詳細のテスト" do
  visit new_task_path
  task = Task.create!(title: 'test_task_01', content: 'testtesttest', end_limit: '2019-12-30', status: '未着手', priority: '高', user_id: @user.id)

  click_on '登録する'
    
  visit task_path(task.id)

  expect(page).to have_content 'test_task_01'
  expect(page).to have_content 'testtesttest'
end
   
scenario "タスクが作成日時の降順に並んでいるかのテスト" do
  visit tasks_path
  click_on "詳細",match: :first
  expect(page).to have_content "test_task_02"
end

scenario "タスクが終了期限順にソートされているかのテスト" do
  visit tasks_path
  click_on "終了期限でソートする"
    
  click_on "詳細",match: :first
  expect(page).to have_content "2019-12-25"
end

scenario "タスクが検索されているかのテスト" do
  visit tasks_path
  fill_in 'タスク名検索', with: 'test_task_01' 
  click_on "検索"
  expect(page).to have_content "test_task_01"
end

scenario "状態が検索されているかのテスト" do
  visit tasks_path
  select '完了', from: '状態検索'
  click_on "検索"
  expect(page).to have_content "完了"
end

scenario "タスクと状態が検索されているかのテスト" do
  visit tasks_path
  fill_in 'タスク名検索', with: 'test_task_02' 
  select '完了', from: '状態検索'
  click_on "検索"
  expect(page).to have_content "test_task_02"
  expect(page).to have_content "完了"
end

scenario "タスクがプライオリティ高いにソートされているかのテスト" do
  visit tasks_path
  click_on "優先順位が高い順にソートする"
  click_on "詳細",match: :first
  expect(page).to have_content "test_task_01"
  end
end