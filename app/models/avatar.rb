# encoding: utf-8
require 'digest/sha1'
class Avatar
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :image_file_name, :type => String
  field :image_content_type, :type => String
  field :image_file_size, :type => Integer

  #belongs_to :user
  #embedded_in :user
  has_one :user

  has_mongoid_attached_file :image,
    :url => "/system/:class/:id/:style_:encrypt_file_name.:extension",
    :styles => {
                :medium => ["50x50", :jpg],
                :normal => ["180x180", :jpg],
                :page_size => ["360x360", :jpg]
               },
    :processors => [:jcropper]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_image, :if => :cropping?

  Paperclip.interpolates :encrypt_file_name do |attachment, style|
    attachment.instance.encrypt_file_name
  end

  def encrypt_file_name
    salt = "avatar_to_users_huacao"
    Digest::SHA1.hexdigest("--#{self.image_file_name}--#{salt}--")
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  # helper method used by the cropper view to get the real image geometry
  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file image.path(style)
  end

  private
  def reprocess_image
    image.reprocess!
  end

end
