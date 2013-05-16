class Provider < ActiveRecord::Base
  attr_accessible :user, :uid, :token, :name

  belongs_to :user

  def self.construct(user, oauth_info)
    create! do |provider|
      provider.user = user
      provider.name = oauth_info[:info][:name] 
      provider.uid = oauth_info[:uid]
      provider.token = oauth_info[:credentials][:token]
    end
  end

  def self.email(user, auth)

    access_token = auth[:credentials][:token]

    imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    # raise "user #{user.email}, #{access_token}"
    imap.authenticate('XOAUTH2', user.email, access_token)
    imap.select('INBOX')
    imap.search(['ALL']).each do |message_id|

      msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
      mail = Mail.read_from_string msg

      puts mail.subject
      puts mail.text_part.body.to_s
      puts mail.html_part.body.to_s
    end
  end
end
