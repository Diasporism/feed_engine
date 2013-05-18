require 'spec_helper'

describe PlatformController do

  let(:token)     { '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY' }
  let(:secret)    { 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV0' }
  let(:user) { User.create(email: 'lsears322@gmail.com') }
  let(:user2) { User.create(email: 'lsears32@gmail.com') }
  let(:current_user) { controller.current_user }
  let!(:provider) { user2.providers.create(name: 'twitter',
                                          uid: 438712211,
                                          token: token,
                                          secret: secret) }

  describe '#index' do
    context 'When the current user is logged in' do
      context 'but has not added any providers to their feed' do
        it 'a gmail client is created' do
          controller.auto_login(user)
          get :index
          response.response_code.should == 200
        end
      end

      context 'and has added Twitter to their feed' do
        it 'a Twitter client is created' do
          controller.auto_login(user2)
          get :index
          response.response_code.should == 200
        end
      end
    end
  end
end