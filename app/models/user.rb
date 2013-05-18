class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email

  has_many :providers

  validates_uniqueness_of :email
  validates_presence_of :email

  def token(provider)
    self.providers.where(name: provider).first.token
  end

  def secret(provider)
    self.providers.where(name: provider).first.secret
  end

  def create_twitter_client
    begin
      Twitter::Client.new(
          :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
          :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'],
          :oauth_token => self.token('twitter'),
          :oauth_token_secret => self.secret('twitter')
      )
    rescue
      nil
    end
  end
end
