#require 'spec_helper'
#
#describe "user visits home show page" do
#  it "has content" do
#    visit "/"
#    expect(page).to have_content "THE INBOX"
#  end
#end
#
#describe "twitter feed" do
#  it "populates inbox with tweets", :vcr do
#    Capybara.current_driver = :mechanize
#    visit '/'
#    click_on "Sign in with Twitter"
#    fill_in "username_or_email", with: "ifeedengines2"
#    fill_in "password", with: "ifeedengines111"
#    click_on "Sign In"
#    click_link "click here"
#    page.should have_content "THE INBOX"
#  end
#end
