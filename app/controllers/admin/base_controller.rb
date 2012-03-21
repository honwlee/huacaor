class Admin::BaseController < ApplicationController
	login_required
	Pagesize = 20
	OrderCondition = [:updated_at, :desc]
end
