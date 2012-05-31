# encoding: utf-8
require File.join(Rails.root,'lib/shared_methods/shared_methods.rb')
class PlantBaseInfo
  include SharedMethods
  include Mongoid::Document
  has_and_belongs_to_many :plants
	field :name, :type => Hash #中、英、拉丁
	field :usage, :type => Integer, :default => 0 #1(亚)
	field :parent_id, :type => Integer # 标识上级的数字（自定义的数字）
	field :huar_home_id, :type => Integer #当前所处层级的数字（自定义的数字）
  field :description, :type => String

  index "name.zh"
  index :parent_id, :uniq => true
  index :huar_home_id, :uniq => true

  HUAR_INFO = [["phylum_name","门",0],["sub_phylum_name","门",1],["pclass_name","纲",0],["sub_pclass_name","纲",0],["porder_name","目",0],['genus_name','属',0]]

  class << self # 获取植物的‘门纲目科属'的名字，加参数如english、lati分别获取英文和拉丁名。
    HUAR_INFO.each do |h_i|
  	  define_method "#{h_i[0]}" do |*args|
  	  	kinds = *args.first || 'zh'
  		  instance_eval("PlantBaseInfo.where('name.zh' => /#{h_i[1]}$/, :usage => #{h_i[2]}).only('name').collect{|p|p.name[kinds]}")
      end
    end
  end

  def self.format_phylum_name # 将植物’门'的名字和id组合成hash供plants _form使用
    Hash[PlantBaseInfo.where('name.zh' => /门$/, :usage => 0).only("name", "id").collect{|p|[p.name['zh'],p.id]}]
  end

  # eg: 门、纲、目 纲的上级为门、下级为目
  def parent_name(kinds='zh') #植物层级目录的上级名字
    parent = PlantBaseInfo.where(:huar_home_id => parent_id).only("name").first
    parent.blank? ? nil : parent.name[kinds]
  end

  def children_name(kinds='zh') # 植物层级目录下级名字
  	children = PlantBaseInfo.where(:parent_id => huar_home_id).only("name").first
  	children.blank? ? nil : children.name[kinds]
  end
end
