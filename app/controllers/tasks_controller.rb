class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #@tasks = Task.all.order(created_at: :desc)
    #@tasks = @tasks.page(params[:page]).per(10)
    @tasks = Task.page(params[:page]).per(10).order('created_at DESC')
    @q = Task.ransack(params[:q])
    @statues = ["未着手","着手中","完了"]
    @priority = {高:0, 中:1 ,低:2 }
   # @tasks = @tasks.paginate_array([], total_count: 145).page(params[:page]).per(10)
    if params[:sort_expired]
      @tasks = Task.all.order(end_limit: :desc)
      #@tasks = Task.page(params[:page]).per(10).order(end_limit: :desc)
    end

    if params[:sort_priority]
      @tasks = Task.order(priority: :desc)
      #tasks = @priority.sort_by{|key,val| val}
      #binding.pry
    
      #@tasks = Task.page(params[:page]).per(10).order(priority: :desc)
    end

    if params[:q]
      #@tasks = @q.result(distinct: true).page(params[:page]).per(10)
      #@tasks = Task.page(params[:page]).per(10)


      @tasks = @q.result(distinct: true)
      #@tasks = @tasks.page(params[:page]).per(10)
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
  