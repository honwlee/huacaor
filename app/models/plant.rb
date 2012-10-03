# encoding: utf-8
require File.join(Rails.root,'lib/shared_methods/shared_methods.rb')
class Plant 
  include SharedMethods
  include Mongoid::Document
  include Mongoid::Timestamps
  BASE_INFO = PlantBaseInfo::HUAR_INFO.collect{|h_i| h_i[0..1]}
  has_and_belongs_to_many :tags
  has_many :pictures
  embeds_many :versions

  field :name_list, :type => Array,:default => []
  index :name_list

  def self.update_by_params_data(plant_data,version_id=nil,plant_id=nil)
    
    plant = plant_id.nil? ? Plant.new : Plant.find(plant_id)

    unless version_id.blank?
      version = plant.versions.find(version_id) 
      version.update_by_params_data(plant_data)
    else
      version = plant.versions.new
      version.update_by_params_data(plant_data)
    end
    version.save
    plant.name_list = plant.versions.collect{|v|v.name[:zh].nil? ? v.name['zh'] : v.name[:zh]}.flatten.uniq
    plant.save

    plant
  end

  def add_tags(tag_ids)
    if tag_ids.class == String
      tag_ids = tag_ids.split(',')
    end
    tag_ids.uniq!

    self.tags.clear
    tags = Tag.find(tag_ids)
    puts "Tags: #{tags.count}"
    self.tags = tags
  end

  def picture_path(thumb=nil)
    thumb.nil? ? pictures.first.image_url : pictures.first.image_url(thumb.to_sym) unless pictures.blank?
  end

  def hot_version
    self.versions.order_by(["points, DESC"]).first
  end
  
  ############################## 每个用户对应一个版本，没有就返回nil ##############################
  def user_version(user_id)
    versions.where(:user_id => user_id).first
  end

  def name(user_id=nil)
    return nil if !user_id.nil? && user_version(user_id).nil?
    user_id.nil? ? hot_version.name : user_version(user_id).name
  end

  def description(user_id=nil)
    return nil if !user_id.nil? && user_version(user_id).nil?
    user_id.nil? ? hot_version.description : user_version(user_id).description
  end
  
  BASE_INFO.each do |b_i| # 获取植物的“门纲目科属”的名称
    define_method b_i[0] do |user_id=nil| # 加user_id为指定版本的信息，不加为准确信息
      return nil if !user_id.nil? && user_version(user_id).nil?
      instance_eval("(user_id.nil? ? self.hot_version : user_version(user_id)).base_info_name.select{|n| n.match(/#{b_i[1]}$/)}")
    end
  end
  ########################################## END ################################################

  def self.find_or_create_by_user_id_and_name(name,user_id)
    plant = Plant.where(:name.in => [name]).first
    plant = Plant.new if plant.nil?
    version = plant.user_version(user_id)
    if version.nil?
      version = plant.versions.new
      version.user_id = user_id
    end
    version.name[:zh] = name
    plant.save
    version.save
    plant.update_attributes(:name_list => plant.versions.collect{|v|v.name['zh']}.flatten.uniq)
    plant
  end

end

class Version # 植物的不同版本
  include SharedMethods
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :plant
  field :points, :type => Integer
  field :name, :type => Hash, :default => {}
  field :description, :type => String
  field :user_id, :type => Integer #用户的id
  field :base_info_ids, :type => Hash # 门、纲、目、科、属的名字 

  #index "name.zh"
  index :user_id, :uniq => true
  index :points
  
  def update_by_params_data(plant_data)
    self.name = {:zh => plant_data[:zh_name],
      :latin => plant_data[:latin_name],
      :english => plant_data[:english_name]}
    self.user_id = plant_data[:user_id]
    self.description = plant_data[:description]
    self.base_info_ids = {:phylum_id => plant_data[:phylum_name]}
  end

  def base_info_name
    base_info_ids.nil? ? [] : PlantBaseInfo.where(:_id.in => base_info_ids.values).only('name').collect{|p|p.name['zh']}
  end
end

