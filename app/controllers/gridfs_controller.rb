require 'mongo'
class GridfsController < ActionController::Metal
  def serve
    gridfs_path = env["PATH_INFO"].gsub("/images/","")
    gridfs_file = Mongo::GridFileSystem.new(Mongoid.database).open(gridfs_path,"r")
    self.response_body = gridfs_file.read
    self.content_type = gridfs_file.content_type
  rescue
    self.status = :file_not_fond
    self.content_type = 'text/plain'
    self.response_body = ''
  end

  def attachment
    id = /(\/documents\/)(\S*)(\/download)/.match(env["PATH_INFO"])[2]
    attached_file = AttachedFile.find(id)
    self.response_body = attached_file.file.read
    self.content_type = attached_file.file_type
    self.content_length = attached_file.file_size
  #rescue
  #  self.status = :file_not_fond
  #  self.content_type = 'text/plain'
  #  self.response_body = ''
  end
end

class ActionController::Metal
  def content_length=(length)
    headers["Content-Length"] = length.to_s
  end
end
