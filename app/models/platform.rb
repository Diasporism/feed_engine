class Platform

  attr_reader :user

  def initialize(user)
    @user = user
  end 

  def timeline
    if tweets.present?
      (tweets + emails).sort! {|x,y| y.received_at <=> x.received_at}
    else
      emails.sort! {|x,y| y.received_at <=> x.received_at} unless emails.empty?
    end
  end

  def self.connect_gmail(gmail_client, user)
    Provider.get_email(gmail_client, user)
  end

  def self.get_email(user)
    Email.email_for_user(user.id)
  end

  private

  def emails
    email_provider(self.user).emails.all
  end

  def tweets
    get_tweets if twitter_client
  end

  def save_tweet(tweets)
    Tweet.save_tweets(user, tweets)
  end

  def twitter_client
    user.create_twitter_client
  end

  def twitter_provider
    Provider.find_provider(user, 'twitter')
  end

  def email_provider(user)
    Provider.find_provider(user.id, 'google_oauth2')
  end

  def get_tweets
    if twitter_provider.tweets.first
      twitter_provider.tweets.order('received_at DESC').limit(20)
    else
      tweet_id = Tweet.latest_tweet_id(user)
      Tweet.check_for_tweets(user, twitter_client, tweet_id)
      twitter_provider.tweets.limit(20)
    end
  end 
end 