require 'rails_helper'

RSpec.describe Task, type: :model do
    #RSpec.feature Task, type: :feature do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
    #save_and_open_page
  end

  it "contentが空ならバリデーションが通らない" do
    #visit new_task_path
    task = Task.new(title: '失敗テスト2', content: '')
    expect(task).not_to be_valid
    #save_and_open_page
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    #visit new_task_path
    task = Task.new(title: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
    #save_and_open_page
  end
end