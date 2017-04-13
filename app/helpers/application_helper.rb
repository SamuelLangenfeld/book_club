module ApplicationHelper
  def format_date(date)
    date.strftime("%m-%d-%Y")
  end

  def format_time(time)
    hour_int=time[0..1].to_i
    am_or_pm=""
    if hour_int>12
      hour_int-=12
      am_or_pm="PM"
    elsif hour_int==0
      hour_int=12
      am_or_pm="AM"
    else
      am_or_pm="AM"
    end

    time_string= hour_int.to_s+time[2..4]+" "+am_or_pm      
  end
end
