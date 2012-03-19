# encoding: utf-8
require 'carrierwave/processing/mini_magick'
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :grid_fs
  # storage :fog

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  def filename
    "#{model.id}" << File.extname(@filename) if original_filename
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [240, 240]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
