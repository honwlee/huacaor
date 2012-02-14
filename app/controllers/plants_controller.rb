class PlantsController < ApplicationController
  # GET /plants
  # GET /plants.json
  def index
    @plants = Plant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @plants }
    end
  end

  # GET /plants/1
  # GET /plants/1.json
  def show
    @plant = Plant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @plant }
    end
  end

  # GET /plants/new
  # GET /plants/new.json
  def new
    @plant = Plant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @plant }
    end
  end

  # GET /plants/1/edit
  def edit
    @plant = Plant.find(params[:id])
  end

  # POST /plants
  # POST /plants.json
  def create
    @plant = Plant.new(params[:plant])

    respond_to do |format|
      if @plant.save
        format.html { redirect_to @plant, :notice => 'Plant was successfully created.' }
        format.json { render :json => @plant, :status => :created, :location => @plant }
      else
        format.html { render :action => "new" }
        format.json { render :json => @plant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plants/1
  # PUT /plants/1.json
  def update
    @plant = Plant.find(params[:id])

    respond_to do |format|
      if @plant.update_attributes(params[:plant])
        format.html { redirect_to @plant, :notice => 'Plant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @plant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plants/1
  # DELETE /plants/1.json
  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy

    respond_to do |format|
      format.html { redirect_to plants_url }
      format.json { head :no_content }
    end
  end
end
