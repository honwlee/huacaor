require 'lib/shared_methods/instance_methods.rb'
class PlantBaseInfo
  include InstanceMethods
  include Mongoid::Document
	field :name, :type => Hash
	field :usage, :type => Integer, :default => 0 #1(亚)
	field :parent_id, :type => Integer
	field :huar_home_id, :type => Integer
  field :description, :type => String
  HUAR_INFO = [["phylum_name","门",0],["sub_phylum_name","门",1],["pclass_name","纲",0],["sub_pclass_name","纲",0],["porder_name","目",0]]

  class << self
    HUAR_INFO.each do |h_i|
  	  define_method "#{h_i[0]}" do |*args|
  	  	kinds = *args.first || 'zh'
  		  instance_eval("PlantBaseInfo.where('name.zh' => /#{h_i[1]}$/, :usage => #{h_i[2]}).only('name').collect{|p|p.name[kinds]}")
      end
    end
  end

  def parent_name(kinds='zh')
    parent = PlantBaseInfo.where(:huar_home_id => parent_id).only("name").first
    parent.blank? ? nil : parent.name[kinds]
  end

  def children_name(kinds='zh')
  	children = PlantBaseInfo.where(:parent_id => huar_home_id).only("name").first
  	children.blank? ? nil : children.name[kinds]
  end
end