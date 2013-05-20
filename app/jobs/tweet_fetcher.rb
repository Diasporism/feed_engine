class TweetFetcher
  @queue = :tweets_queue

  def self.perform(args)
    user = User.find(args['user_id'])
    tweet_id = Provider.find_provider(user, 'twitter').tweets.first.tweet_id
    twitter_client = user.create_twitter_client
    Tweet.check_for_tweets(user, twitter_client, tweet_id)
    Resque.enqueue_in(1.minutes, TweetFetcher, :user_id => args['user_id'])
  end
end