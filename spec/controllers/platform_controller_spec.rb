require 'spec_helper'

describe PlatformController do

  let(:token)     { '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY' }
  let(:gmail_token) { 'ya29.AHES6ZR-u1-h5Wxk7nAsAm41KYQWXBVKR8iwvihInOKziPXJxFCS0Q' }
  let(:secret)    { 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV0' }
  let(:user) { User.create(email: 'lsears322@gmail.com') }
  let(:user2) { User.create(email: 'lsears32@gmail.com') }
  let(:user_3) { User.create(email: 'gschooltest@gmail.com') }
  let(:current_user) { controller.current_user }
  let!(:twitter_provider) { user2.providers.create(name: 'twitter',
                                          uid: 438712211,
                                          token: token,
                                          secret: secret) }
  let!(:google_provider) { user_3.providers.create(name: 'google_oauth2',
                                          uid: 438712231,
                                          token: gmail_token) }

  describe '#index' do
    context 'When the current user is logged in' do
      context 'but has not added any providers to their feed' do
        xit 'a gmail client is created' do
          controller.auto_login(user_3)

          get :index
          response.response_code.should == 200
        end
      end

      context 'and has added Twitter to their feed' do

        before do 
          Provider.stub(:get_email).and_return(true)
        end

        xit 'a Twitter client is created' do
          controller.auto_login(user2)
          get :index
          response.response_code.should == 200
        end
      end

      context "a user has authorized both gmail and twitter" do

        # let!(:user) {User.create(email: "yolo@email.com")}
        # let!(:google_oauth) {FactoryGirl.create(:provider, user: user)}
        # let!(:mail_1) { FactoryGirl.create(:mail, provider: provider)} 
        # let!(:mail_2) { FactoryGirl.create(:mail, provider: provider)}

        before do 
          Provider.stub(:get_email)
          User.stub(:find).and_return(user)
        end

        it "returns a list of tweets and emails, sorted by date" do
          pending "need to fix factory girl" 
          expect(assigns(:timeline).first.name).to eq mail_1.name
        end
      end
    end
  end
end