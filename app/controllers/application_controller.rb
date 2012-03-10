class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "index"

  helper_method :current_user
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :login_required
  def login_required
    if current_user.blank?
      session[:return_to] = request.fullpath
      flash[:notice] = "请先登录"
      redirect_to new_session_path and return
    else
      return true
    end
  end
end
