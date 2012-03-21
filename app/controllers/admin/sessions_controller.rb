class Admin::SessionsController < ApplicationController
	layout nil
  def new

  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      ret_url = session[:return_to] || new_session_path
      redirect_to "/admin/login"
    else
      flash[:notice] = flash_error("邮箱或密码错误")
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/admin/login"
    flash[:notice] = flash_success("成功退出")
  end
end
