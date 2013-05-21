class Feed

  def self.format_time(time)
    current_time = DateTime.now.new_offset(Rational(0, 24))
    seconds = ((current_time - DateTime.parse(time.to_s)) * 24 * 60 * 60).to_i
    if seconds < 60
      'Just now'
    elsif seconds < 3600
      more_than_minute(seconds)
    elsif seconds < (3600 * 24)
      more_than_hour(seconds)
    else
      time.strftime('%e %b')
    end
  end

  private

  def self.more_than_minute(seconds)
    t = seconds / 60
    if t == 1
      "#{t} minute ago"
    else
      "#{t} minutes ago"
    end
  end

  def self.more_than_hour(seconds)
    t = ((seconds / 60) / 60)
    if t == 1
      "#{t} hour ago"
    else
      "#{t} hours ago"
    end
  end

end