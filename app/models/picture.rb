class Picture
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :plant
  belongs_to :user

  field :usage, :type => Integer, :default => 0

  mount_uploader :image, ImageUploader

  index :kinds
end
