require 'rails_helper.rb'

RSpec.feature "タスク管理機能", type: :feature do

  before do
    @user = User.create(name: 'test', email: 'aaa@gmail.com', password: 'password',password_confirmation: 'password')
    Label.create!(title: 'label01', user_id: @user.id)
    Label.create!(title: 'label02', user_id: @user.id)
    visit new_session_path
 
    fill_in 'session[email]', with: @user.email 
    fill_in 'session[password]', with: 'password' 
    click_on "Log in"
  end

  scenario "タスク作成と同時にラベルを貼り付け出来るテスト" do
    click_on "タスク一覧へ"
    click_on "新しくタスクを投稿する"

    fill_in 'task_title', with: 'test_task_01'
    fill_in 'task_content', with: 'testtesttest'
    fill_in 'task_end_limit', with: '2019-06-20'
    select '未着手', from: 'task_status'
    select '高', from: 'task_priority'

    click_on "登録する"
    
    check 'task_label_ids_1'
    click_on "登録する"
    
    click_on "詳細",match: :first
    expect(page).to have_content 'label01'
  end
   
  scenario "タスクに付与したラベルで検索が出来るテスト" do

    click_on "タスク一覧へ"
    click_on "新しくタスクを投稿する"

    fill_in 'task_title', with: 'test_task_01'
    fill_in 'task_content', with: 'testtesttest'
    fill_in 'task_end_limit', with: '2019-06-20'
    select '未着手', from: 'task_status'
    select '高', from: 'task_priority'

    click_on "登録する"
    check 'task_label_ids_3'
    click_on "登録する"
  
    select 'label01', from: 'ラベル'
    click_on "検索"
    
    expect(page).to have_content "test_task_01"
    click_on "詳細",match: :first
    expect(page).to have_content 'label01'
  end

  scenario "タスクからラベルを変更できるか" do

    click_on "タスク一覧へ"

    click_on "新しくタスクを投稿する"
    fill_in 'task_title', with: 'test_task_01'
    fill_in 'task_content', with: 'testtesttest'
    fill_in 'task_end_limit', with: '2019-06-20'
    select '未着手', from: 'task_status'
    select '高', from: 'task_priority'
    click_on "登録する"
    
    check 'task_label_ids_5'
    click_on "登録する"
    
    click_on "編集",match: :first
    check 'task_label_ids_6'
    
    click_on "commit"
    click_on "詳細",match: :first
    
    expect(page).not_to have_content "label01"  
   end
end