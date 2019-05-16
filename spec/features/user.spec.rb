require 'rails_helper.rb'

RSpec.feature "タスク管理機能", type: :feature do

 # background do
 # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
 #   FactoryBot.create(title: 'test_task_01', content: 'testtesttest', end_limit: '2019-05-25', status: '未着手', priority: '高')
 #   FactoryBot.create(title: 'test_task_02', content: 'samplesample', end_limit: '2019-05-27', status: '未着手', priority: '高')
 #   FactoryBot.create(title: 'test_task_03', content: 'samplesample', end_limit: '2019-05-29', status: '未着手', priority: '高')
 # end


  before do
    # 事前にテストユーザーを登録する
    visit new_user_path
    fill_in '名前', with: 'test' 
    fill_in 'メールアドレス', with: 'test@gmail.com' 
    fill_in 'パスワード', with: 'password' 
    fill_in '確認用パスワード', with: 'password' 
    click_on "Create my account"
    click_on "タスク一覧へ"
    click_on "新しくタスクを投稿する"
    fill_in 'task_title', with: 'ユーザー１がタスク作成'
    fill_in 'task_content', with: 'testtesttest'
    fill_in 'task_end_limit', with: '2019-05-22'
    select '未着手', from: 'task_status'
    select '高', from: 'task_priority'
    click_on "登録する"
    click_on "登録する"
    click_on "Logout"
  end

  scenario "ログインしないでタスク投稿出来ない事" do
    visit tasks_path
    expect(page).to have_content "ログインしてください!"
  end


  scenario "他のユーザーが作成したタスクが確認出来ない事" do
    visit new_user_path
    fill_in '名前', with: 'test2' 
    fill_in 'メールアドレス', with: 'test2@gmail.com' 
    fill_in 'パスワード', with: 'password' 
    fill_in '確認用パスワード', with: 'password' 
    
    click_on "Create my account"
    click_on "タスク一覧へ"
    expect(page).not_to have_content "ユーザー１がタスク作成"
  end

  scenario "ユーザ登録（create）をした時、同時にログイン出来ている事" do
    visit new_user_path
    fill_in '名前', with: 'test3' 
    fill_in 'メールアドレス', with: 'test3@gmail.com' 
    fill_in 'パスワード', with: 'password' 
    fill_in '確認用パスワード', with: 'password' 

    click_on "Create my account"
    
    expect(page).to have_content "Logout"
    
  end

  scenario "ログイン中にユーザー登録画面に行けない事" do
    visit new_user_path
    fill_in '名前', with: 'test3' 
    fill_in 'メールアドレス', with: 'test3@gmail.com' 
    fill_in 'パスワード', with: 'password' 
    fill_in '確認用パスワード', with: 'password' 
    click_on "Create my account"
    visit new_user_path
    expect(page).to have_content "既にログインしています"
  end

  scenario "自分以外の他ユーザーのページにいけない事" do
    visit new_user_path
    fill_in '名前', with: 'test4' 
    fill_in 'メールアドレス', with: 'test4@gmail.com' 
    fill_in 'パスワード', with: 'password' 
    fill_in '確認用パスワード', with: 'password' 
    click_on "Create my account"
    visit user_path(User.first.id)
    expect(page).to have_content "ユーザーが違います"
  end
end

#save_and_open_page