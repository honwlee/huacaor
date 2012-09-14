# encoding: utf-8
class Tag
  include Mongoid::Document
  has_and_belongs_to_many :plants
  field :name, :type => String
  field :usage, :type => Integer, :default => 0
  field :description, :type => String
  field :icon_name, :type => String # 标签图标名称

  index :name

  # usage
  Normal = 0 # 普通标签
  Category = 1 # 类型
  Sharp = 2 # 花型
  Color = 3 # 花色

  scope :category, where(:usage => Category)
  scope :sharp, where(:usage => Sharp)
  scope :color, where(:usage => Color)

  def self.usages
  	[["普通", Normal], ["类型", Category], ["花型", Sharp], ["花色", Color]]
  end

  def self.usages_except_normal
    usages = self.usages
    usages.delete_at(0)
    return usages
  end

  def usage_name
  	ua = self.class.usages.select{|u| u[1] == self.usage}
  	return nil if ua.blank?
  	return ua[0][0]
  end

end
