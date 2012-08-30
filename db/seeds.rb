# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
# 类型
tags = Tag.create([
  {:name => "乔木", :usage => 1, :icon_name => "h1"},
  {:name => "灌木", :usage => 1, :icon_name => "h2"},
  {:name => "藤本", :usage => 1, :icon_name => "h3"},
  {:name => "蕨类", :usage => 1, :icon_name => "h4"},
  {:name => "草本", :usage => 1, :icon_name => "h5"},
  {:name => "乔本", :usage => 1, :icon_name => "h6"},
  {:name => "两瓣", :usage => 2, :icon_name => "fw2"},
  {:name => "三瓣", :usage => 2, :icon_name => "fw3"},
  {:name => "四瓣", :usage => 2, :icon_name => "fw4"},
  {:name => "五瓣", :usage => 2, :icon_name => "fw5"},
  {:name => "六瓣", :usage => 2, :icon_name => "fw6"},
  {:name => "蝶形", :usage => 2, :icon_name => "fwfly"},
  {:name => "唇形", :usage => 2, :icon_name => "fwmouth"},
  {:name => "穗状", :usage => 2, :icon_name => "fwg"},
  {:name => "头状", :usage => 2, :icon_name => "fwh"},
  {:name => "花小而不明显", :usage => 2, :icon_name => "fwno"},
  {:name => "其它", :usage => 2, :icon_name => "others"},
  {:name => "红花", :usage => 3, :icon_name => "red"},
  {:name => "蓝花", :usage => 3, :icon_name => "blue"},
  {:name => "紫花", :usage => 3, :icon_name => "pulp"},
  {:name => "绿花", :usage => 3, :icon_name => "green"},
])