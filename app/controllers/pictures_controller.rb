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

    picture = Picture.new(
      :image => params[:filedata],
      :user_id => current_user.id,
      :desc => params[:desc].strip,
      :usage => Picture::FOR_PLANTS
    )
    picture.save

    unless params[:plant_zh_name].blank?
      plant = Plant.find_or_create_by_user_id_and_name(params[:plant_zh_name],current_user.id,params[:desc])
      plant.pictures << picture
      redirect_to edit_plant_path(plant,:picture_id => picture.id) and return
    end

    redirect_to picture_path(picture) 
  end

  def show
    @picture = Picture.includes(:plant).find(params[:id])
    @plant = @picture.plant
    @user = @picture.user
    @user_pictures = @user.pictures.limit(8)
  end

end
