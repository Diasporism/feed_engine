class Provider < ActiveRecord::Base

  attr_accessible :name, :uid, :token, :secret, :user

  belongs_to :user

  validates_uniqueness_of :uid
  validates_presence_of :uid
  validates_presence_of :name

  belongs_to :user

  def self.construct(user, oauth_info)
    create! do |provider|
      provider.user = user
      provider.name = oauth_info['info']['name'] 
      provider.uid = oauth_info['uid']
      provider.token = oauth_info['credentials']['token']
    end
  end

  def email(user)

    access_token = token

    imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)

    imap.authenticate('XOAUTH2', user.email, access_token)
    imap.select('INBOX')
    my_mail = []
    imap.search(['ALL']).each do |message_id|

      msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
      mail = Mail.read_from_string msg

      my_mail << mail
      # raise mail.subject
      # puts mail.text_part.body.to_s
      # puts mail.html_part.body.to_s
    end
    my_mail
  end
end
