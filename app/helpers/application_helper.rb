module ApplicationHelper
  def onDev
    return Rails.env == "development"
  end
  
end
