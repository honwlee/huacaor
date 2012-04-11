# encoding: utf-8
class Plant 
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  has_many :pictures
  embeds_one :brief
  field :name, :type => Hash
  field :characteristic, :type => String
  field :description, :type => String

  def update_by_params_data(plant_data)
    self.name = {:zh => plant_data[:zh_name], :latin => plant_data[:latin_name], :english => plant_data[:english_name]}
    Plant.fields.keys.each do |field|
      # instance_eval("self.#{field} = #{plant_data[field.to_sym].to_s}") unless plant_data[field.to_sym].blank?
      write_attribute(field.to_sym, plant_data[field.to_sym]) unless plant_data[field.to_sym].blank?
    end
  end

  def picture_path(thumb=nil)
    thumb.nil? ? pictures.first.image_url : pictures.first.image_url(thumb.to_sym) unless pictures.blank?
  end
end

class Brief
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :plant
end

