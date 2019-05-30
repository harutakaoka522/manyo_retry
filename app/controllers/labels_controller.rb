class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]
  
  def index
    @labels = current_user.labels.page(params[:page]).per(5)
  end

  def new
    if params[:back]
      @label = Label.new(label_params)
    else
      @label = Label.new 
    end
  end

  def show
  end

  def edit
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to labels_path, notice: "ラベルを作成しました"
    else
      render 'new'
    end
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベルを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice:"ラベルを削除しました"
  end

  private

  def label_params
    params.require(:label).permit(:title)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end
