# encoding: utf-8
class Tag
  include Mongoid::Document
  has_and_belongs_to_many :plants
  field :name, :type => String
  field :usage, :type => Integer
  field :description, :type => String

  index :name
end
