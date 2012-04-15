class UploadsController < ApplicationController
  #include ProxiesHelper
  skip_before_filter :verify_authenticity_token

  def photo
    raise "需要头像图片" if params[:photo].blank?
		#return logger.debug request.raw_post
    photo = Photo.new(params[:photo])
    photo.save!

    origin_path = photo.image.url(:original)
    origin_geometry = Paperclip::Geometry.from_file(photo.image.path(:original))
    origin = { :src => origin_path, :width => origin_geometry.width, :height => origin_geometry.height }

    pagesize_path = photo.image.url(:page_size)
    pagesize_geometry = Paperclip::Geometry.from_file(photo.image.path(:page_size))
    pagesize = { :width => pagesize_geometry.width, :height => pagesize_geometry.height }

    render :text => '{response}' + { :status => true, :id => photo.id, :origin => origin, :page_size => pagesize }.to_json.to_s + '{/response}'
  rescue StandardError => error
    render :text => '{response}' + { :status => false, :message => error.to_s }.to_json.to_s + '{/response}'
  end

  def avatar
    raise "缺少头像ID" if params[:id].blank?

    avatar = Photo.find(params[:id])
    avatar.update_attributes(params[:photo])
    current_user.avatar_id = avatar.id
    current_user.save!

    redirect_to '/'
  rescue StandardError => error
    render :text => '{response}' + { :status => false, :message => error }.to_json.to_s + '{/response}'
  end

end
