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


  def new
    @plant = Plant.new
    respond_to do |format|
      format.html
      format.json { render :json => @plant }
    end
  end

  def edit
    #[["phylum_name","门",0],["sub_phylum_name","门",1],["pclass_name","纲",0],["sub_pclass_name","纲",0],["porder_name","目",0],['genus_name','属',0]]
    # @sub_phylum_name = Hash[PlantBaseInfo.sub_phylum_name]
    # @pclass_name = Hash[PlantBaseInfo.pclass_name]
    # @sub_pclass_name = Hash[PlantBaseInfo.sub_pclass_name]
    # @porder_name = Hash[PlantBaseInfo.porder_name]
    # @genus_name = Hash[PlantBaseInfo.genus_name]
    @phylum_name = PlantBaseInfo.format_phylum_name
    @plant = Plant.find(params[:id])
    @version_id = @plant.user_version_id(current_user.id)
  end

  def create
    plant = Plant.new
    params[:plant][:user_id] = current_user.id
    version_id = plant.update_by_params_data(params[:plant])
    plant.save

    unless params[:picture_id].blank?
      picture = Picture.find(params[:picture_id])
      plant.pictures << picture
    end
    return redirect_to picture_path(params[:picture_id]) unless params[:picture_id].blank?
    redirect_to plant_path(params[:id])
    # redirect_to edit_plant_path(plant, :version_id => version_id) 
  end

  def update
    plant = Plant.find(params[:id])
    params[:plant][:user_id] = current_user.id
    plant.update_by_params_data(params[:plant],params[:version_id])
    plant.save
    return redirect_to picture_path(params[:picture_id]) unless params[:picture_id].blank?
    redirect_to plant_path(params[:id])
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plants_path
  end

end
