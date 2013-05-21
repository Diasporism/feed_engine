class Platform

  attr_reader :user

  def initialize(user)
    @user = user
  end 

  def timeline
    if tweets != nil
      (tweets + emails).sort! {|x,y| y.received_at <=> x.received_at}
    else
      emails.order('received_at DESC')
    end
  end

  private

  def tweets
    get_tweets if twitter_client
  end

  def emails
    gmail_client = self.user.create_imap_client
    
    connect_gmail(gmail_client)

    get_email
  end 

  def save_tweet(tweets)
    Tweet.save_tweets(self.user, tweets)
  end

  def connect_gmail(gmail_client)
    Provider.get_email(gmail_client, self.user)
  end

  def get_email
    Email.email_for_user(self.user.id)
  end

  def twitter_client
    self.user.create_twitter_client
  end

  def twitter_provider
    Provider.find_provider(self.user, 'twitter')
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