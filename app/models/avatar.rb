# encoding: utf-8
class Avatar
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :image_file_name, :type => String
  field :image_content_type, :type => String
  field :image_file_size, :type => Integer

  belongs_to :user

  has_mongoid_attached_file :image,
    :path => "#{Rails.root}/public/system/:class/:id/:style_:updated_at.:extension",
    :url => "/system/:class/:id/:style_:updated_at.:extension",
    #:url => ':attachment/:id/:style.extension',
    :styles => {
                :medium => ["50x50", :jpg],
                :normal => ["180x180", :jpg],
                :page_size => ["360x360", :jpg]
               }

  
end