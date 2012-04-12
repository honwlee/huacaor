class Admin::PlantBaseInfoController < Admin::BaseController
  def index
    @plant_base_info = PlantBaseInfo.page(params[:page] || 1).per(Pagesize)
  end

  def show

  end
end