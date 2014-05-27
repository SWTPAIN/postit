module ApplicationHelper
  def fix_url (url)
  url.start_with?("http://") ? url : ("http://" + url)
  end 

  def display_datetime(datetime)
    if logged_in? && current_user.time_zone
      datetime.in_time_zone(current_user.time_zone).strftime("%d/%m/%Y %l:%M%P %Z")
    else
      datetime.in_time_zone.strftime("%d/%m/%Y %l:%M%P %Z")
    end
  end

  def display_votes(vote)
    if (vote <= 1 && vote >= -1)
      "#{vote} vote"   
    else
      "#{vote} votes"
    end
  end

end
