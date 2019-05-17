class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :ensure_correct_user, only: [:show]
  before_action :logging_in, only: [:new, :create, :confirm]

  def new
    @user = User.new
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
    
    def show
      @user = User.find(params[:id])
    end

    def confirm
      @user = User.new(user_params)
      render :new if @user.invalid?
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if @current_user.id !=  @user.id
      redirect_to current_user, alert: 'ユーザーが違います'
    end
  end

