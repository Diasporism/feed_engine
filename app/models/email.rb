class Email < ActiveRecord::Base

  belongs_to :provider

  attr_accessible :from, :subject, :body, :received_at, :uid

  def self.save_email(mail, user)
    provider = find_provider(user, 'google_oauth2')

    create do |m|
      m.from = encode_mail(mail.from.first)
      m.subject = encode_mail(mail.subject)
      m.body = encode_mail(mail.text_part.body) if mail.text_part
      m.received_at = encode_mail(mail.received)
      m.provider_id = provider.id
    end
  end

  def self.email_for_user(user)
    provider = find_provider(user, 'google_oauth2')
    self.where(provider_id: provider.id)
  end

  def self.find_provider(user, provider)
    Provider.find_provider(user, provider)
  end

  def self.encode_mail(field)
    field.to_s.force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '')
  end

end