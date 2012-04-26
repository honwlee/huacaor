# encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def hello
    mail(:to => 'luoping0425@gmail.com', :subject => '测试邮件')
  end

  def reset_pwd(user, new_pwd)
    @user = user
    @new_pwd = new_pwd
    @url = login_url(:host => APP_CONFIG['host']) 
    mail(:to => @user.email, :subject => "您的账户信息：")
  end
end
