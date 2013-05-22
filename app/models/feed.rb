class Feed
  SECONDS_PER_HOUR = 60 * 60
  SECONDS_PER_DAY = SECONDS_PER_HOUR * 24

  attr_reader :time

  def initialize(time)
    @time = time
  end

  def self.format_time(time)
    new(time).format_time
  end

  def format_time
    if elapsed_time < 60
      'Just now'
    elsif elapsed_time < SECONDS_PER_HOUR
      more_than_minute
    elsif elapsed_time < SECONDS_PER_DAY
      more_than_hour
    else
      time.strftime('%e %b')
    end
  end

  def elapsed_time
    @elapsed_time ||= ((current_time - DateTime.parse(time.to_s)) * SECONDS_PER_DAY).to_i
  end

  def current_time
    @current_time ||= DateTime.now.new_offset(Rational(0, 24))
  end

  def more_than_minute
    t = elapsed_time / 60
    unit = t == 1 ? 'minute' : 'minutes'
    "#{t} #{unit} ago"
  end

  def more_than_hour
    t = (elapsed_time / SECONDS_PER_HOUR)
    unit = t == 1 ? 'hour' : 'hours'
    "#{t} #{unit} ago"
  end
end
