class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit]
  
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
  end

  def destroy
  end

  private

  def label_params
    params.require(:label).permit(:title)
  end

  def set_label
    @label = Label.find(params[:id])
  end

end
