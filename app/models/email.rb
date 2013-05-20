class Email < ActiveRecord::Base

  belongs_to :provider

  attr_accessible :from, :subject, :body, :received, :uid


end