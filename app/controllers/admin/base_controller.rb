# encoding: utf-8
class Admin::BaseController < ApplicationController
	#login_required
	layout "admin"
	Pagesize = 20
	OrderCondition = [:updated_at, :desc]
end
