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

  def self.latest_tweet_id(user)
    tweet = Provider.find_provider(user, 'twitter').tweets.order('received_at DESC').first
    tweet ? tweet.tweet_id : 0
  end

end
