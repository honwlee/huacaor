# encoding: utf-8
class Picture
  include Mongoid::Document
  include Mongoid::Timestamps

  FOR_PLANTS = 0 
  FOR_USER = 1

  field :usage, :type => Integer, :default => FOR_PLANTS 
  # field :desc, :type => String

  index :usage

  belongs_to :plant
  belongs_to :user
  embeds_many :comments

  mount_uploader :image, ImageUploader


  def self.create_picture(filedata,usage=0)
    picture = Picture.new
    picture.usage = usage
    picture.image = filedata
    picture.save!
    #FileUtils.rm_rf("#{Rails.root}/public/uploads")
    return picture
  end

  def plant_name
    plant = self.plant
    if plant.blank?
      return "待鉴定"
    elsif plant.zh_name.blank?
      return "未知"
    else
      return plant.zh_name
    end
  end

end
