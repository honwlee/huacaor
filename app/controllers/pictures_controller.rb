# encoding: utf-8
class PicturesController < ApplicationController
  before_filter :login_required

  def new

  end

  def create
    if params[:filedata].blank?
      flash[:notice] = flash_error("请选择图片")
      redirect_to new_picture_path and return
    end
    params[:user_id] = current_user.id
    picture = Picture.create_picture(params)

    unless params[:plant_zh_name].blank?
      plant = picture.create_parent_plant(params[:plant_zh_name].strip)
      redirect_to edit_plant_path(plant,:picture_id => picture.id) and return
    end

    redirect_to picture_path(picture) 
  end

  def show
    @current_user = current_user
    @picture = Picture.includes(:plant).find(params[:id])
    @plant = @picture.plant
    @user = @picture.user
    @user_pictures = @user.pictures.limit(8)
  end

end
