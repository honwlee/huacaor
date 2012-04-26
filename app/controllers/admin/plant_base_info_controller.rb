# encoding: utf-8
class Admin::PlantBaseInfoController < Admin::BaseController
  layout "admin"
  Cls = 'n3'

  def index
    @plant_base_info = PlantBaseInfo.page(params[:page] || 1).per(Pagesize)
    @cls = Cls
  end

  def show

  end
end