# encoding: utf-8
class Picture
  FOR_PLANTS = 0 
  FOR_USER = 1
  PLANT_METHODS = ['name','description','phylum_name','sub_phylum_name','pclass_name','sub_pclass_name','porder_name','genus_name']
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :plant
  belongs_to :user

  field :usage, :type => Integer, :default => FOR_PLANTS 
  field :describe_info, :type => Hash, :default => {}

  mount_uploader :image, ImageUploader

  index :usage

  def self.create_picture(data,usage=0)
    picture = Picture.new
    picture.usage = usage
    picture.image = data[:filedata]
    picture.describe_info = {:desc => data[:desc]}
    picture.user_id = data[:user_id]
    picture.save!
    #FileUtils.rm_rf("#{Rails.root}/public/uploads")
    return picture
  end

  def create_parent_plant(name)
    plant = Plant.find_or_create_by_user_id_and_name(name,user_id)
    plant.pictures << self
    plant
  end

  PLANT_METHODS.each do |method|
    define_method "plant_#{method}" do |u_id=user_id|
      plant.blank? ? "未知" : plant.send(method) #热门版本#plant.send(method,u_id) 个人版本
      #instance_eval("self.plant.#{method} user_id")
    end
  end

end
