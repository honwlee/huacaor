# encoding: utf-8
class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :plant
  # embeds_many :comments

  field :content, :type => String

end

# class Comment
#   include Mongoid::Document
#   include Mongoid::Timestamps
#   belongs_to :user

#   embedded_in :note

#   field :content, :type => String

# end