class Provider < ActiveRecord::Base
  attr_accessible :user, :uid, :token, :name

  belongs_to :user
end
