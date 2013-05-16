class Provider < ActiveRecord::Base
  attr_accessible :name, :uid

  belongs_to :user

  validates_uniqueness_of :uid
  validates_presence_of :uid
  validates_presence_of :name
end
