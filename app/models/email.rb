class Email < ActiveRecord::Base

  belongs_to :provider

  attr_accessible :from, :subject, :body, :received

  def self.save(mail)
    create! do |m|
      m.from = mail.from
      m.subject = mail.subject
      m.body = mail.text_part.body
      m.received = mail.received
    end

  end

  def self.email_for_user(user)

  end


end