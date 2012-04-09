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

  #index :kinds

  #def self.create_picture(filedata, user_id, usage=FOR_PLANTS)
  def self.create_picture(opts={})
    picture = self.new(
      :usage => opts[:usage] || FOR_PLANTS,
      :image => opts[:filedata],
      :user_id => opts[:user_id],
      :desc => opts[:desc]
    )
    picture.save!
    #FileUtils.rm_rf("#{Rails.root}/public/uploads")
    return picture
  end

end
