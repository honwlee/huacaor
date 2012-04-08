# encoding: utf-8
class Picture
  FOR_PLANTS = 0 
  FOR_USER = 1
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :plant
  belongs_to :user

  field :usage, :type => Integer, :default => FOR_PLANTS 
  field :desc, :type => String

  mount_uploader :image, ImageUploader

  index :kinds

  #def self.create_picture(filedata, user_id, usage=FOR_PLANTS)
  def self.create_picture(opts={})
    picture = self.new(
      :usage => params[:usage] || FOR_PLANTS,
      :image => params[:filedata],
      :user_id => params[:user_id]
    )


    # picture.usage = params[:usage] || FOR_PLANTS

    # picture.usage = usage
    # picture.image = filedata
    # picture.user_id = user_id
    picture.save!
    #FileUtils.rm_rf("#{Rails.root}/public/uploads")
    return picture
  end

end
