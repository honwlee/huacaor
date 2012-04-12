# encoding: utf-8
class PlantsController < ApplicationController

  def index
    @plants = Plant.all

    respond_to do |format|
      format.html
      format.json { render :json => @plants }
    end
  end

  def show
    @plant = Plant.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @plant }
    end
  end


  def new
    @plant = Plant.new

    respond_to do |format|
      format.html
      format.json { render :json => @plant }
    end
  end

  def edit
    
    @plant = Plant.find(params[:id])
  end

  def create
    plant = Plant.new
    #plant.update_by_params_data(params[:plant])
    #plant.save

    unless params[:filedata].blank?
      picture = Picture.create_picture(params[:filedata], current_user.id)
      plant.pictures << picture
    end

    redirect_to edit_plant_path(plant)
  end

  def update
    plant = Plant.find(params[:id])

    plant.update_by_params_data(params[:plant])
    plant.save
    #plant.pictures << Picture.create_picture(params[:plant][:filedata]) unless params[:plant][:filedata]
    redirect_to plants_path
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plants_path
  end
end
