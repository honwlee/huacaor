# encoding: utf-8
class HomeController < ApplicationController
  def index
    #@pictures = Picture.all(sort:"created_at, desc").limit(10)
    @plants = Plant.all.order('updated_at desc').limit(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pictures }
    end
  end

  def about

  end

end
