# encoding: utf-8
class Family
  include Mongoid::Document
  field :name, :type => String
end
