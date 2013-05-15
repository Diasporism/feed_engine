class User < ActiveRecord::Base

  attr_accessible :email

  has_many :providers

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    user_email = auth[:info][:email]
    User.find_by_email(user_email) || User.create!(email: user_email)
  end

end
