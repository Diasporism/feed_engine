ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara'
require 'capybara/mechanize'
require 'factory_girl_rails'
#require 'vcr'
#require 'webmock'

FactoryGirl.find_definitions

#VCR.configure do |c|
#  c.cassette_library_dir = 'spec/vcr/cassettes'
#  c.hook_into :webmock
#end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end