class TweetFetcher
  @queue = :tweets_queue

  def self.perform(args)
    puts 'Checking for tweets'
    user = User.find(args['user_id'])
    tweet_id = Tweet.latest_tweet_id(user)
    twitter_client = user.create_twitter_client
    Tweet.check_for_tweets(user, twitter_client, tweet_id)
    Resque.enqueue_in(1.minutes, TweetFetcher, :user_id => args['user_id'])
  end
end