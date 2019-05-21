class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]
  before_action :logging_in, only: [:new, :create, :confirm]
  def index
    if current_user.admin?
      @users = User.all.includes(:tasks).page(params[:page]).per(10)
    else
      redirect_to current_user, alert: '権限がありません'
    end
    
  end

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new 
    end
  end

  def show
  end

  def edit
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end
    
  def confirm
    @user = User.new(user_params)
    render :new if @user.invalid?
  end

    def update
      respond_to do |format|
        if @user.update(user_params)
         format.html { redirect_to @user, notice: 'ユーザー情報をアップデートしました.' }
         format.json { render :show, status: :ok, location: @user }
        else
          render 'edit'
         format.html { render :edit }
         format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # def destroy
    #   @user.destroy
    #   respond_to do |format|
    #     format.html { redirect_to users_url, notice: 'ユーザー情報を削除しました.' }
    #   end
    # end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end


 def ensure_correct_user
  if current_user.admin?
  elsif @current_user.id !=  @user.id
     redirect_to current_user, alert: 'ユーザーが違います'
    end
 end

 def logging_in 
  redirect_to tasks_path, alert: '既にログインしています' if logged_in?
 end
end

