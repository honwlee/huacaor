# encoding: utf-8
class Genus
  include Mongoid::Document
  field :name, :type => String
end
