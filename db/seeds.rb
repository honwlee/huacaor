# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
# 类型
Tag.create(:name => "乔木", :usage => 1, :icon_name => "h1")
Tag.create(:name => "灌木", :usage => 1, :icon_name => "h2")
Tag.create(:name => "藤本", :usage => 1, :icon_name => "h3")
Tag.create(:name => "蕨类", :usage => 1, :icon_name => "h4")
Tag.create(:name => "草本", :usage => 1, :icon_name => "h5")
Tag.create(:name => "乔本", :usage => 1, :icon_name => "h6")
Tag.create(:name => "两瓣", :usage => 2, :icon_name => "fw2")
Tag.create(:name => "三瓣", :usage => 2, :icon_name => "fw3")
Tag.create(:name => "四瓣", :usage => 2, :icon_name => "fw4")
Tag.create(:name => "五瓣", :usage => 2, :icon_name => "fw5")
Tag.create(:name => "六瓣", :usage => 2, :icon_name => "fw6")
Tag.create(:name => "蝶形", :usage => 2, :icon_name => "fwfly")
Tag.create(:name => "唇形", :usage => 2, :icon_name => "fwmouth")
Tag.create(:name => "穗状", :usage => 2, :icon_name => "fwg")
Tag.create(:name => "头状", :usage => 2, :icon_name => "fwh")
Tag.create(:name => "花小而不明显", :usage => 2, :icon_name => "fwno")
Tag.create(:name => "其它", :usage => 2, :icon_name => "others")
Tag.create(:name => "红花", :usage => 3, :icon_name => "red")
Tag.create(:name => "黄花", :usage => 3, :icon_name => "#ff0")
Tag.create(:name => "蓝花", :usage => 3, :icon_name => "blue")
Tag.create(:name => "紫花", :usage => 3, :icon_name => "pulp")
Tag.create(:name => "绿花", :usage => 3, :icon_name => "green")
Tag.create(:name => "白花", :usage => 3, :icon_name => "#fff")
