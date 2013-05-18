require 'spec_helper'

describe PlatformController do

  let(:token)     { '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY' }
  let(:secret)    { 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV0' }
  let(:user) { User.create(email: 'lsears322@gmail.com') }
  let(:user2) { User.create(email: 'lsears32@gmail.com') }
  let(:current_user) { controller.current_user }
  let!(:twitter_provider) { user2.providers.create(name: 'twitter',
                                          uid: 438712211,
                                          token: token,
                                          secret: secret) }
  let!(:google_provider) { user2.providers.create(name: 'google_oauth2',
                                          uid: 438712231,
                                          token: token,
                                          secret: secret) }

  describe '#index' do

    context 'When the current user is logged in' do
      context 'but has not added any providers to their feed' do
        xit 'a gmail client is created' do
          controller.auto_login(user)
          get :index
          response.response_code.should == 200
        end
      end

      context 'and has added Twitter to their feed' do

        before do 
          Provider.stub(:get_email).and_return(true)
        end

        it 'a Twitter client is created' do
          controller.auto_login(user2)
          get :index
          response.response_code.should == 200
        end
      end

      context 'and has added Facebook to their feed' do
        it 'a Facebook client is created'
      end
    end
  end
end