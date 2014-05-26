module ApplicationHelper
  def fix_url (url)
  url.start_with?("http://") ? url : ("http://" + url)
  end 

  def display_datetime(datetime)
    datetime.strftime("%d/%m/%Y %l:%M%P %Z")
  end

  def display_votes(vote)
    if (vote <= 1 && vote >= -1)
      "#{vote} vote"   
    else
      "#{vote} votes"
    end
  end

end
