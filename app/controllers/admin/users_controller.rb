class Admin::UsersController < ApplicationController
  before_action :not_admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
 # before_action :admin_edit_destroy, only: [:edit, :update, :destroy]
 # before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]
  #before_action :logging_in, only: [:new, :create, :confirm]
  def index
    if current_user.admin?
     # @users = User.all.includes(:tasks).page(params[:page]).per(4)
      @users = User.includes(:tasks).order('created_at asc').page(params[:page]).per(3)
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
 #   @users = @user.tasks.page(params[:page]).per(5)
  end

  def edit
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render 'new'
    end
  end
    
  def confirm
    @user = User.new(user_params)
    render :new if @user.invalid?
  end

    def update
      if @user.update(user_params)
    #    binding.pry
        redirect_to admin_user_path(@user), notice: 'ユーザーを編集しました'
      else
    #    binding.pry
        redirect_to admin_users_path, alert: 'ユーザーの編集に失敗しました'
      end
    end

  def destroy
    if current_user.id != @user.id && @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました!'
    else
      redirect_to admin_users_path, alert: 'ユーザーの削除に失敗しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def not_admin_user
    if current_user.admin?
    else
    redirect_to current_user, alert: '権限がありません'
    end
  end

  # def admin_edit_destroy
  #   if current_user == @user && current_user.admin?
  #     redirect_to admin_user_path(@user), alert: '管理者の内容は編集できません'
  #     #ログイン中のユーザーが管理者権限を持っていて、かつログイン中とは違うユーザーだったらリンクを表示する。
  #  end
  #end
end

