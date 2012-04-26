# encoding: utf-8
class Admin::PicturesController < ApplicationController
	def index
    @pictures = Picture.order_by(OrderCondition).page(params[:page] || 1).per(Pagesize)
  end 
end
