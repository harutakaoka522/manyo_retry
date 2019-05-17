class ApplicationController < ActionController::Base
  before_action :current_user
  protect_from_forgery with: :exception
  include SessionsHelper
  def set_current_user
    @current_user = User.find_by(id: session[:user.id])
  end
end
