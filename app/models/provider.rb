class Provider < ActiveRecord::Base
  attr_accessible :user, :uid, :token, :name

  belongs_to :user

  def self.construct(user, oauth_info)
    create! do |provider|
      user = user
      name = oauth_info[:info][:name] 
      uid = oauth_info[:uid]
      token = oauth_info[:credentials][:token]
    end
  end
end
