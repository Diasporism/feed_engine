class Email < ActiveRecord::Base

  belongs_to :provider

  attr_accessible :from, :subject, :body, :received_at, :uid

  def self.save_email(mail, user)
    provider = find_provider(user, 'google_oauth2')

    create do |m|
      m.from = mail.from.first.to_s.force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '')
      m.subject = mail.subject.to_s.force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '')
      m.body = mail.text_part.body.to_s.force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '') if mail.text_part
      m.received_at = mail.received.to_s.force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '')
      m.provider_id = provider.id
    end
  end

  def self.email_for_user(user)
    provider = find_provider(user, 'google_oauth2')
    self.where(provider_id: provider.id)
  end

  private

  def self.find_provider(user, provider)
    Provider.find_provider(user, provider)
  end


end