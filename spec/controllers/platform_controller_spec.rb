require 'spec_helper'

describe PlatformController do

  describe '#index' do

    context "a user has authorized both gmail and twitter" do

    let(:user) {User.create(email: "yolo@email.com")}
    let!(:platform) {Platform.new(user)}
    let!(:provider) {Provider.create(name: "google_oauth2", user: user, uid: "123456789", token: "token")}
    let!(:mail) { Email.create(from: "example", subject: "ahoy", body: "hoy", received_at: "Sat May 18 20:02:13 +0000 2013", uid: "07846")}

      before do 
        controller.stub(:current_user).and_return(user)

        mail.provider = provider
        mail.save!
      end

      it "returns a list of tweets and emails, sorted by date" do
        get :index
        expect(assigns(:timeline).first.subject).to eq mail.subject
      end
    end
  end
end