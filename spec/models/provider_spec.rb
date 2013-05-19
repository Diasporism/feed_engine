require 'spec_helper'

describe Provider do

  let(:user) { User.create(email: 'email@gmail.com') }

  let!(:oauth_info) { { 
                      'provider' => "google_oauth2",
                      'uid' => "123456789",
                      'info' => {
                          'name' => "John Doe",
                          'email '=> "john@company_name.com",
                          :first_name => "John",
                          :last_name => "Doe",
                          :image => "https://lh3.googleusercontent.com/url/photo.jpg"
                      },
                      'credentials' => {
                          'token' => "token",
                          :refresh_token => "another_token",
                          :expires_at => 1354920555,
                          :expires => true
                      },
                      :extra => {
                          :raw_info => {
                              :id => "123456789",
                              :email => "user@domain.example.com",
                              :verified_email => true,
                              :name => "John Doe",
                              :given_name => "John",
                              :family_name => "Doe",
                              :link => "https://plus.google.com/123456789",
                              :picture => "https://lh3.googleusercontent.com/url/photo.jpg",
                              :gender => "male",
                              :birthday => "0000-06-25",
                              :locale => "en",
                              :hd => "company_name.com"
                          }
                      }


    }}

  describe ".create" do 

    context "when correct paramaters are given" do 

      before do 
        Provider.stub(:validates_uniqueness_of).and_return(true)
        Provider.create(user: user, name: "John Doe", uid: "123456789", token: "token")
      end

      it "creates a new provider object" do 
        expect(Provider.count).to eq 1
        expect(Provider.first.name).to eq "John Doe"
      end

      it "links that provider to its user" do 
        expect(Provider.first.user).to eq user
      end
    end

    context "when incorrect paramaters are given" do

      it "does not save the provider" do 
      end 
    end
  end

  describe ".construct" do

    context "when a provider passes in the entire oath params" do 

      before do 
        Provider.construct(user, oauth_info)
      end

      it "creates a new provider" do
        expect(Provider.count).to eq 1 
      end
    end 
  end
end
