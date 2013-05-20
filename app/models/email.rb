class Email < ActiveRecord::Base

  belongs_to :provider

  attr_accessible :from, :subject, :body, :received_at, :uid

  def self.save(mail, user)
    provider = find_provider(user, 'google_oauth2')

    create! do |m|
      m.from = mail.from.first.to_s
      m.subject = mail.subject.to_s
      m.body = mail.text_part.body.to_s
      m.received_at = mail.received.to_s
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