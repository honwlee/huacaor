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

    picture = Picture.create_picture(
      :filedata => params[:filedata],
      :user_id => current_user.id,
      :desc => params[:desc].strip || ""
    )

    unless params[:plant_zh_name].blank?
      n = params[:plant_zh_name]
      plant = Plant.where(:zh_name => n).first
      plant = Plant.create(:zh_name => n) if plant.blank?
      plant.pictures << picture
      redirect_to edit_plant_path(plant) and return
    end

    redirect_to picture_path(picture) 
  end

  def show
    @picture = Picture.find(params[:id])
    @plant = @picture.plant
    @user = @picture.user
    @user_pictures = @user.pictures.limit(8)
  end

end
