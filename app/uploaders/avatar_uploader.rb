# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  ThumbSize = [50, 50]
  NormalSize = [180, 180]
  PageSize = [360, 360]
  

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  
  version :thumb do
    process :resize_to_fit => ThumbSize
  end
  
  version :normal do
    process :resize_to_fill => NormalSize
  end

  version :page_size do
    process :resize_to_fill => PageSize
  end

  version :original

end
