class Picture
  FOR_PLANTS = 0 
  FOR_USER = 1
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :plant
  belongs_to :user

  field :usage, :type => Integer, :default => FOR_PLANTS 

  mount_uploader :image, ImageUploader

  index :kinds

  def self.create_picture(filedata,usage=FOR_PLANTS)
    picture = self.new
    picture.usage = usage
    picture.image = filedata
    picture.save!
    #FileUtils.rm_rf("#{Rails.root}/public/uploads")
    return picture
  end

end
