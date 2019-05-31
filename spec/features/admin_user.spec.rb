require 'rails_helper.rb'

RSpec.feature "タスク管理機能", type: :feature do
  before do
    @users = []
    @admin = User.create(name: 'admin', email: 'admin@gmail.com', password: 'password',password_confirmation: 'password', admin: true)
    @user = User.create(name: 'user1', email: 'user1@gmail.com', password: 'password',password_confirmation: 'password', admin: false)
    visit new_session_path

    fill_in 'session[email]', with: @admin.email 
    fill_in 'session[password]', with: 'password' 
    click_on "Log in"
  end

  scenario "ユーザー情報が確認できること" do
    click_on "管理画面一覧"
    click_on "確認"
    expect(page).to have_content 'user1'
    expect(page).to have_content 'タスク数'
  end
  
  scenario "ユーザー情報が編集できること" do
    click_on "管理画面一覧"
    click_on "編集" 
    fill_in 'user_name', with: 'user2'
    fill_in 'user_password', with: 'password'
    click_on "更新する"
    expect(page).to have_content 'user2'
    expect(page).to have_content 'ユーザーを編集しました'
  end

  scenario "ユーザー情報を削除出来ること" do
    click_on "管理画面一覧"
    click_on "削除" 
    expect(page).to have_content 'ユーザーを削除しました'
  end

  scenario "新しくユーザー情報を登録できること" do
    click_on "管理画面一覧"
    click_on "新しくユーザーを作成する"

    fill_in 'user_name', with: 'user3' 
    fill_in 'user_email', with: 'user3@gmail.com' 
    fill_in 'user_password', with: 'password' 
    click_on "登録する"
    click_on "管理画面一覧"
    expect(page).to have_content 'user3'
    save_and_open_page
  end
end