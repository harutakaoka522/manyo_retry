class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      @tasks = Task.all
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
  