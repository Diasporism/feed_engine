class Tweet < ActiveRecord::Base
  belongs_to :provider

  attr_accessible :provider_id, :tweet_id, :text, :screen_name, :profile_image_url

  def self.save_tweets(user, tweets)
    tweets.each do |tweet|
      provider_id = Provider.find_provider(user, 'twitter').id
      Tweet.create(provider_id: provider_id,
                   tweet_id: tweet[:id_str],
                   text: tweet[:text],
                   screen_name: tweet[:user][:screen_name],
                   profile_image_url: tweet[:user][:profile_image_url])
    end
  end

  def self.check_for_tweets(user, twitter_client, tweet_id)
    tweets = twitter_client.home_timeline(options = {since_id: tweet_id.to_i})
    save_tweets(user, tweets)
  end
end
