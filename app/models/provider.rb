class Provider < ActiveRecord::Base
  attr_accessible :name, :uid, :token, :secret

  belongs_to :user
  has_many :tweets

  validates_uniqueness_of :uid
  validates_presence_of :uid
  validates_presence_of :name

  def self.find_provider(user, provider)
    find_by_user_id_and_name(user.id, provider)
  end
end
