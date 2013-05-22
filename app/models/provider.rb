class Provider < ActiveRecord::Base

  attr_accessible :name, :uid, :token, :secret, :user, :refresh_token

  belongs_to :user
  has_many :tweets
  has_many :emails

  validates_uniqueness_of :uid
  validates_presence_of :uid
  validates_presence_of :name

  def self.construct(user, oauth_info)
    create! do |provider|
      provider.user = user
      provider.name = oauth_info['info']['name'] 
      provider.uid = oauth_info['uid']
      provider.token = oauth_info['credentials']['token']
    end
  end

  def self.get_email(imap, user)
    provider = Provider.find_provider(user.id, 'google_oauth2')
    delete_emails(provider)

    refresh_access_token(provider)

    imap.authenticate('XOAUTH2', user.email, user.token('google_oauth2'))
    imap.select('INBOX')

    imap.search(['ALL']).each do |message_id|
    #imap.search(["NOT", "SEEN"]).each do |message_id|
      msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
      mail = Mail.read_from_string(msg)
      Email.save_email(mail, user)
    end
  end

  def self.find_provider(user, provider)
    find_by_user_id_and_name(user, provider)
  end

  private

  def self.delete_emails(provider)
    provider.emails.destroy_all
  end

  def self.refresh_access_token(provider)
    hash = {'client_id' => ENV['GOOGLE_CLIENT_ID'], 'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
            'refresh_token' => provider.refresh_token, 'grant_type' => 'refresh_token'}
    response = RestClient.post 'https://accounts.google.com/o/oauth2/token', hash
    json = JSON.parse(response)
    access_token = json['access_token']
    provider.update_attribute(:token, access_token)
  end
end
