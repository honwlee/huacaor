class Plant
  include Mongoid::Document
  include Mongoid::Timestamps
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  has_many :pictures
  embeds_one :brief
  validates_presence_of :title
  field :name, :type => Hash
end

class Brief
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :plant
end

