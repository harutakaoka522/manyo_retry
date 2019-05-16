module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def not_login
    redirect_to new_session_path, alert: 'ログインしてください!' unless logged_in?
  end

  def logging_in
    redirect_to current_user, alert: '既にログインしています' if logged_in?
  end
end
