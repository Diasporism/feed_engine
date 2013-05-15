class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email

  has_many :providers

  validates_uniqueness_of :email
  validates_presence_of :email

end
