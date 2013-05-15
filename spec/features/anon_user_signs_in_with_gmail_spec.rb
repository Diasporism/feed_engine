require 'spec_helper'
require_relative 'spec_helper'

describe "sign in" do

  it "allows the user to sign in with gmail" do
    Capybara.current_driver = :mechanize
    visit "/"
    page.should have_content "Sign in with Google"
    mock_auth_hash
    ENV["omniauth.auth"] = mock_auth_hash
    visit session_new_path

    page.should have_content "stuff"
  end
end

## in spec/requests/top_spec.rb
#describe "access top page" do
#  it "can sign in user with Twitter account" do
#    visit '/'
#    page.should have_content("Sign in with Twitter")
#    mock_auth_hash
#    click_link "Sign in"
#    page.should have_content("mockuser")  # user name
#    page.should have_css('img', :src => 'mock_user_thumbnail_url') # user image
#    page.should have_content("Sign out")
#  end
#
#  it "can handle authentication error" do
#    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
#    visit '/'
#    page.should have_content("Sign in with Twitter")
#    click_link "Sign in"
#    page.should have_content('Authentication failed.')
#  end
#
#end