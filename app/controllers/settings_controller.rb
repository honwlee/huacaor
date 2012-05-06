# encoding: utf-8
class SettingsController < ApplicationController
  before_filter :login_required, :except => [:forget_pwd, :reset_pwd]

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = flash_success("操作成功")
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
    flash[:notice] = flash_success("操作成功")
    redirect_to settings_password_path
  rescue => e
    flash[:notice] = flash_error(e.to_s)
    render :action => "password"
  end

  def forget_pwd
    #@title = "重置密码"
  end

  def reset_pwd
    if params[:email].blank?
      flash[:notice] = flash_error('请输入注册邮箱')
      return render :action => :forget_pad
    end

    user = User.where(:email => params[:email]).first
    if user.blank?
      flash[:notice] = flash_error('该用户不存在')
      return render :action => :forget_pad
    end

    new_pwd = String.random(6)
    user.password = new_pwd
    user.save
    
    # 发送邮件
    UserMailer.reset_pwd(user, new_pwd).deliver

    flash[:notice] = flash_success("密码已通过短信发送，请重新登录")
    redirect_to login_path 
  end

  #################### Avatar ####################
  def avatar
    @avatar = Avatar.new
    @title = "修改头像"
  end

  def update_avatar
    raise "缺少头像ID" if params[:avatar_id].blank?
    avatar = Avatar.find(params[:avatar_id])
    avatar.update_attributes(params[:avatar])
    if current_user.avatar_id.nil?
      current_user.points += POINTS['upload_avatar'].to_i
    end
    current_user.avatar_id = avatar.id

    flash[:notice] = current_user.save ? flash_success : flash_error
    redirect_to '/settings/avatar'
  end

end
