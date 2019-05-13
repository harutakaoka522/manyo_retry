class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
      @tasks = Task.all.order(created_at: :desc)
        #作成したものから上に表示
      if params[:sort_expired]
        @tasks = Task.all.order(end_limit: :desc)
        #終了期限の降順に並び替えられたタスク一覧ページ
      else
        @tasks = Task.all.order(created_at: :desc)
      end
    end
  
    def new
      if params[:back]
        @task = Task.new(task_params)
      else
        @task = Task.new 
      end
    end
  
    def show
    end
      
    def create
      @task = Task.new(task_params)
      if @task.save
       #binding.pry
        redirect_to tasks_path, notice: "タスクを作成しました"
      else
        render 'new'
      end
    end
  
    def edit
    end
  
    def confirm
      @task = Task.new(task_params)
      render :new if @task.invalid?
    end
  
    def update
      if @task = Task.update(task_params)
        redirect_to tasks_path, notice: "タスクを更新しました"
      else
        render 'edit'
      end
    end
  
    def destroy
      @task.destroy
      redirect_to tasks_path, notice:"タスクを削除しました"
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title, :content, :end_limit, :status, :priority)
    end
  
    def set_task
      @task = Task.find(params[:id])
    end
end
  