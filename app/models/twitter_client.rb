class TwitterClient

  def self.user(token, secret)
    Twitter::Client.new(
        :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
        :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'],
        :oauth_token => token,
        :oauth_token_secret => secret
    )
  end
end
