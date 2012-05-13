# Jcropper paperclip processor
#
# This processor very slightly changes the default thumbnail processor in order to work properly with Jcrop
# the jQuery cropper plugin.

module Paperclip
  # Handles thumbnailing images that are uploaded.
  class Jcropper < Thumbnail

    def transformation_command
      scale, crop = @current_geometry.transformation_to(@target_geometry, crop?)
      trans = []
      target = @attachment.instance
      if target.cropping?
        trans << "-crop" << "#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}"
        puts trans.inspect
      else                        
        trans << "-crop" << "#{crop}" << "+repage" if crop
      end
      trans << "-resize" << "#{scale}" unless scale.nil? || scale.empty?
      trans
    end


  end

end

