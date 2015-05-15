class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
