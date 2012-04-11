# encoding: utf-8
class HomeController < ApplicationController
  def index
    @pictures = Picture.all.order_by([:created_at, :desc]).limit(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pictures }
    end
  end

  def about

  end

end
