# encoding: utf-8
class Admin::TagsController < Admin::BaseController
  
  Cls = 'n2'

  # GET /tags
  def index
    @cls = Cls
    @tags = Tag.page(params[:page] || 1).per(Pagesize)
  end

  # GET /tags/1
  def show
    @cls = Cls
    @tag = Tag.find(params[:id])
  end

  # GET /tags/new
  def new
    @cls = Cls
    @title = "添加标签"
    @tag = Tag.new
  end

  # POST /tags
  def create
    @tag = Tag.new(params[:tag])

    if @tag.save
      flash[:notice] = flash_success()
      redirect_to admin_tags_path
    else
      render :action => "new"
    end
  end

  # GET /tags/1/edit
  def edit
    @cls = Cls
    @title = "修改标签"
    @tag = Tag.find(params[:id])

    render :new
  end

  # PUT /tags/1
  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
      flash[:notice] = flash_success()
      redirect_to admin_tags_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to tags_url
  end
end
