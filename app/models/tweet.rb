class Tweet < ActiveRecord::Base
  belongs_to :provider

  attr_accessible :provider_id, :tweet_id, :text, :screen_name, :profile_image_url, :received_at

  validates_uniqueness_of :tweet_id, :scope => :provider_id

  def self.save_tweets(user, tweets)
    tweets.each do |tweet|
      provider_id = Provider.find_provider(user, 'twitter').id
      Tweet.create(provider_id: provider_id,
                   tweet_id: tweet[:id].to_s,
                   text: tweet[:text],
                   screen_name: tweet[:user][:screen_name],
                   profile_image_url: tweet[:user][:profile_image_url],
                   received_at: DateTime.parse(tweet[:created_at].to_s))
    end
  end

  def self.check_for_tweets(user, twitter_client, tweet_id)
    tweets = twitter_client.mentions_timeline(options = {since_id: tweet_id.to_i + 1})
    save_tweets(user, tweets)
  end

  def self.format_time(tweet_time)
    current_time = DateTime.now.new_offset(Rational(0, 24))
    seconds = ((current_time - DateTime.parse(tweet_time.to_s)) * 24 * 60 * 60).to_i
    if seconds < 60
      'Just now'
    elsif seconds < 3600
      more_than_minute(seconds)
    elsif seconds < (3600 * 24)
      more_than_hour(seconds)
    else
      tweet_time.strftime('%e %b')
    end
  end

  def self.latest_tweet_id(user)
    tweet = Provider.find_provider(user, 'twitter').tweets.order('received_at DESC').first
    tweet ? tweet.tweet_id : 0
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
