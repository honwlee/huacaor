# encoding: utf-8
module ApplicationHelper
  ########## 格式化日期时间 ##########
  def date_time(time)
    time = time.localtime
    norm = DateTime.now
    format = "%Y年%m月%d日 %H:%M"
    arr = ["今天", "明天", "后天", "前天", "昨天"]
    s = (time - norm).to_i.seconds.abs #秒数差
    d = (time.to_date - norm.to_date).to_i #天数差

    if s <= 1.minute
      return "刚刚" if time < norm
      return (s < 1 ? 1 : s).to_s << "秒后"
    elsif s <= 1.hour
      return (s/60).to_i.to_s << "分钟" << (time < norm ? "前" : "后")
    elsif d.abs <= 2
      return arr[d] << time.strftime(" %H:%M")
    elsif time.year == norm.year
      return time.strftime(format[3..-1])
    else
      return time.strftime(format)
    end
  rescue
    nil
  end

  def onDev
    return Rails.env == "development"
  end

  def tag_choose_class(tag_ids, tag_id)
    return "choose" if tag_ids && tag_ids.include?(tag_id)
    return ""
  end

end
