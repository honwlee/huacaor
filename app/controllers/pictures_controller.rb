# encoding: utf-8
class PicturesController < ApplicationController

  def new

  end

  def create
    # plant = Plant.new
    #plant.update_by_params_data(params[:plant])
    #plant.save
    if params[:filedata].blank?
      flash[:notice] = flash_error("请选择图片")
      redirect_to new_picture_path and return
    end

    picture = Picture.create_picture(
      :filedata => params[:filedata],
      :user_id => current_user.id,
      :desc => params[:desc].strip || ""
    )

    if params[:plant_zh_name]
      
    end

      # plant.pictures << picture


    redirect_to edit_plant_path(plant)
  end


end
