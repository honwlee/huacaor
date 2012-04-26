# encoding: utf-8
module ApplicationHelper
  def onDev
    return Rails.env == "development"
  end
  
end
