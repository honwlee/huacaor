# encoding: utf-8
class UsersController < ApplicationController
  Pagesize = 12

  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @pictures = Picture.order_by([:created_at, :desc]).page(params[:page] || 1).per(Pagesize)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = flash_success("操作成功")
      redirect_to profile_settings_path
    else
      flash.now.notice = @user.errors.full_messages.join(',')
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = flash_success("操作成功")
      redirect_to edit_user_path(@user)
    else
      flash.now.notice = @user.errors[:last_name]
      render :action => "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
