# encoding: utf-8
class PlantBaseInfoController < ApplicationController
  def index
    @plant_base_info = PlantBaseInfo.page(params[:page] || 1).per(Pagesize)
  end

  def show
    plant_base_info = PlantBaseInfo.find(params[:id])
    children = PlantBaseInfo.where(:parent_id => plant_base_info.huar_home_id)
    children_info = []
    children.each do |c|
      c_h = {}
      c_h["name"] = c.name
      c_h["id"] = c.id
      children_info << c_h
    end
    render :json => children_info
  end
end