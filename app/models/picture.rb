# encoding: utf-8
class Picture
  FOR_PLANTS = 0 
  FOR_USER = 1
  PLANT_METHODS = ['name','description','phylum_name','sub_phylum_name','pclass_name','sub_pclass_name','porder_name','genus_name']
  include Mongoid::Document
  include Mongoid::Timestamps

  field :usage, :type => Integer, :default => FOR_PLANTS 
  field :describe_info, :type => Hash, :default => {}

  index :usage

  belongs_to :plant
  belongs_to :user
  #embeds_many :comments
  has_many :comments

  mount_uploader :image, ImageUploader

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

  # 此图片的发布者的其他图片
  def user_other_pictures(num=-1)
    num = num.to_i
    pictures = self.user.pictures.where(:id.ne => self.id)
    return pictures.limit(num) if num > 0
    return pictures 
  end

  PLANT_METHODS.each do |method|
    define_method "plant_#{method}" do |u_id=user_id|
      if plant.blank?
        return "未知"
      else
        plant.send(method)
      end
      # plant.blank? ? "未知" : plant.send(method) #热门版本#plant.send(method,u_id) 个人版本
      #instance_eval("self.plant.#{method} user_id")
    end
  end

  def tags
    if self.plant
      return self.plant.tags
    else
      return []
    end
  end

end
