# encoding: utf-8
require File.join(Rails.root,'lib/shared_methods/instance_methods.rb')
class Plant 
  include InstanceMethods
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :tags
  #belongs_to :user
  has_many :pictures
  embeds_many :versions
  field :zh_name
  index :zh_name
  BASE_INFO = PlantBaseInfo::HUAR_INFO.collect{|h_i| h_i[0..1]}
  def update_by_params_data(plant_data,version_id=nil)
    unless version_id.blank?
      version = self.versions.find(version_id) 
      version.update_by_params_data(plant_data)
    else
      version = Version.new
      version.update_by_params_data(plant_data)
      self.versions << version
    end
    version.save
    version.id
  end

  def picture_path(thumb=nil)
    thumb.nil? ? pictures.first.image_url : pictures.first.image_url(thumb.to_sym) unless pictures.blank?
  end

  def hot_version
    self.versions.order_by(["points, DESC"]).first
  end
  
  def user_version(user_id)
    versions.where(:user_id => user_id).first
  end

  def user_version_id(user_id)
    user_version(user_id).nil? ? nil : user_version(user_id).id
  end

  def name
    hot_version && hot_version.name
  end

  def description
    hot_version && hot_version.description
  end
  
  def self.find_or_create_by_user_id_and_name(name,user_id,description=nil)
    plant = Plant.find_or_initialize_by(:zh_name => name)
    version = plant.user_version(user_id)
    plant.versions.create(:user_id => user_id,:description => description) if version.nil?
    plant.save
    plant
  end

  BASE_INFO.each do |b_i|
    define_method b_i[0] do 
      instance_eval("self.hot_version && self.hot_version.base_info_name.select{|n| n.match(/b_i[1]$/)}")
    end
  end

end

class Version
  include InstanceMethods
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
    # Version.fields.keys.each do |field|
    #   # instance_eval("self.#{field} = #{plant_data[field.to_sym].to_s}") unless plant_data[field.to_sym].blank?
    #   write_attribute(field.to_sym, plant_data[field.to_sym]) unless plant_data[field.to_sym].blank?
    # end
  end

  def base_info_name
    base_info_ids.nil? ? [] : PlantBaseInfo.where(:id.in => base_info_ids.values).only('name').collect{|p|p.name['zh']}
  end
end

