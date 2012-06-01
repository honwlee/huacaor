# encoding: utf-8
class PlantsController < ApplicationController
  before_filter :login_required, :except => ['show','index']#, :only => ["new","create","update"]
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


  # def new
  #   @plant = Plant.new
  #   respond_to do |format|
  #     format.html
  #     format.json { render :json => @plant }
  #   end
  # end

  def edit
    @phylum_name = PlantBaseInfo.format_phylum_name
    @plant = Plant.find(params[:id])
    @version = @plant.user_version(current_user.id)
    @version_id = @version.nil? ? nil : @version.id 
    # phylum_id = @version.base_info_ids['phylum_id']
    # pclass_id = @version.base_info_ids['pclass_id']
    # porder_id = @version.base_info_ids['porder_id']
    # genus_id = @version.base_info_ids['genus_id']
  end

  # def create
  #   params[:plant][:user_id] = current_user.id
  #   version_id = Plant.update_by_params_data(plant,params[:plant])

  #   unless params[:picture_id].blank?
  #     picture = Picture.find(params[:picture_id])
  #     plant.pictures << picture
  #   end
  #   return redirect_to picture_path(params[:picture_id]) unless params[:picture_id].blank?
  #   redirect_to plant_path(params[:id])
  #   #redirect_to edit_plant_path(plant, :version_id => version_id) 
  # end

  def update
    params[:plant][:user_id] = current_user.id
    Plant.update_by_params_data(params[:plant],params[:version_id],params[:id])
    return redirect_to picture_path(params[:picture_id]) unless params[:picture_id].blank?
    redirect_to plant_path(params[:id])
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plants_path
  end

end
