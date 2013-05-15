class Provider < ActiveRecord::Base
  attr_accessible :name, :uid

  belongs_to :user
end
