require 'spec_helper'

describe "user visits home show page" do
  it "has content" do
    visit "/"
    expect(page).to have_content "homepage"
  end
end
