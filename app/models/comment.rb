# encoding: utf-8
class Comment
  include Mongoid::Document
  belongs_to :user
end
