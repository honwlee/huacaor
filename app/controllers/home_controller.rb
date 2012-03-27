# encoding: utf-8
class HomeController < ApplicationController
  def index
    @plants = Plant.all.order('updated_at desc').limit(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @plants }
    end
  end

  def about

  end

end
