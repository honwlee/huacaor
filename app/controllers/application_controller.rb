# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "index"

  helper_method :current_user
  helper_method :login_required
  helper_method :admin_required

  ############################## 输出处理结果信息给用户 ############################
  def flash_html(*args)
    opts = args.extract_options!
    status = args[0] || opts[:status]
    msg = args[1] || opts[:msg]
    
    '<div id="flash-notice"><div class="' + status + '">' + msg + '</div></div>'
  end
  
  def flash_success(msg = "恭喜您，操作成功")
      flash_html('success', msg)
  end
  
  def flash_error(msg = "出错啦~")
      flash_html('error', msg)
  end 

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    if current_user.blank?
      base_login_condition("请先登录",new_session_path)
    else
      return true
    end
  end

  def admin_required
    if current_user.blank?
      base_login_condition("请先登录",new_admin_session_path)
    elsif !current_user.is_admin 
      base_login_condition("对不起，权限不够",new_admin_session_path)
    else
      redirect_to ''
    end
  end

  def base_login_condition(notice,redirect_path)
    session[:return_to] = request.fullpath
    flash[:notice] = flash_error(notice)
    return redirect_to redirect_path 
  end
end

class String
  def self.random(len=6)
    chars = ("a".."z").to_a + ("0".."9").to_a
    new_str = ""
    1.upto(len){|i| new_str << chars[rand(chars.size-1)] }
    return new_str 
  end
end
