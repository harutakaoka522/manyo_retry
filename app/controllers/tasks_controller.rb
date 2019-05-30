class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :not_current_user, only: [:show, :edit, :update, :destroy]
  before_action :not_login

  def index
    @tasks = current_user.tasks.order('created_at DESC')
    @q = Task.ransack(params[:q])
    @statues = ["未着手","着手中","完了"]

    if params[:sort_expired]
      @tasks = Task.all.order(end_limit: :desc)
    end

    if params[:sort_priority]
     @tasks = Task.all.order(priority: :asc)
    end

    if params[:q]
      @tasks = @q.result(distinct: true)
    end
    @tasks = @tasks.page(params[:page]).per(10)
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
    @task = current_user.tasks.build(task_params)
    if @task.save   
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end
  
  def update
    if @task.update(task_params)
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
    params.require(:task).permit(:title, :content, :end_limit, :status, :priority,  label_ids: [])
  end
  
  def set_task
    @task = Task.find(params[:id])
  end

  def not_current_user
    if @current_user.id !=  @task.user.id
      redirect_to tasks_path, alert: '権限がありません'
    end
  end
end
  