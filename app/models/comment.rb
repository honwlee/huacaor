# encoding: utf-8
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user
  embedded_in :picture

  field :content, :type => String
  field :user_id, :type => Integer
  field :status, :type => Boolean, :default => 1

  # status
  Normal = 1
  Deleted = 0

  default_scope where(:status => Normal)

end
