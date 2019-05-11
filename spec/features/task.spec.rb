require 'rails_helper.rb'

RSpec.feature "タスク管理機能", type: :feature do
  before do
    # 事前にタスクを作成する
    Task.create!(title: 'test_task_01', content: 'testtesttest', end_limit: '2019-05-22', status: '未着手', priority: '高')
    Task.create!(title: 'test_task_02', content: 'samplesample', end_limit: '2019-05-22', status: '未着手', priority: '高')
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
   fill_in 'task_end_limit', with: '2019-05-22'
   select '未着手', from: 'task_status'
   select '高', from: 'task_priority'

  click_on '登録する'
  

  expect(page).to have_content 'test_task_01'
  expect(page).to have_content 'testtesttest'
end

  scenario "タスク詳細のテスト" do
    visit new_task_path
    task = Task.create!(title: 'test_task_01', content: 'testtesttest', end_limit: '2019-12-30', status: '未着手', priority: '高')

    click_on '登録する'
    
    visit task_path(task.id)

    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end
  
  # scenario "タスク昇順テスト" do
  #   visit tasks_path
  # expect(Task.order("created_at DESC").each(&:id))
  # end
end