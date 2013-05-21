require 'spec_helper'

describe Platform do 

  let(:user) {User.create(email: "yolo@email.com")}
  let(:platform) {Platform.new(user)}
  let!(:provider) {Provider.create(name: "google_oauth2", user: user, uid: "123456789", token: "token")}
  let!(:mail) { Email.create(from: "example", subject: "ahoy", body: "hoy", received_at: "Sat May 18 20:02:13 +0000 2013", uid: "07846")}

  before do 
    mail.provider = provider
    mail.save!
  end

  describe "#initialize" do 

    context "given a user has been passed in" do 

      it "has a user" do 
        expect(platform.user).to eq user
      end
    end
  end

  describe ".user_timeline" do 

    context "given a user has emails and tweets" do 

      it "gathers all messages for that user" do 
        expect(platform.user_timeline.count).to eq 1
      end
    end
  end
end 