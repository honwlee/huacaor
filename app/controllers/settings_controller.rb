class SettingsController < ApplicationController
  before_filter :login_required

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = "操作成功"
      redirect_to settings_profile_path
    else
      flash.now.notice = @user.errors[:last_name]
      render :action => "profile"
    end
  end

  def password
    @title = '修改密码' 
  end

  def update_password
    @title = '修改密码' 

    raise '新密码不能为空' if params[:new_password].blank?
    raise '您的当前密码有误' unless User.encrypt(params[:old_password], current_user.password_salt) == current_user.password_hash
    raise '新密码与旧密码相同，操作被取消' if params[:new_password] == params[:old_password]

    current_user.password = params[:new_password]
    current_user.save!
    flash[:notice] = "操作成功"
    redirect_to settings_password_path
  rescue => e
    flash.now.notice = e.to_s
    render :action => "password"
  end
  

end
