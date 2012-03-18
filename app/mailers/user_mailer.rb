class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def reset_pwd(user, new_pwd)
    @user = user
    @new_pwd = new_pwd
    @url = login_url 
  end
end
