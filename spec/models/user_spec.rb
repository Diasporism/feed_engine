require 'spec_helper'

describe User do
  let(:token)     { '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY' }
  let(:secret)    { 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV0' }
  let(:user)      { User.create(email: 'lsears322@gmail.com') }
  let(:user2)      { User.create(email: 'lsears32@gmail.com') }
  let!(:provider) { user.providers.create(name: 'twitter',
                                          uid: 438712211,
                                          token: token,
                                          secret: secret) }
  describe '#token' do
    it 'retrieves the token for the current user' do
      expect(user.token('twitter')).to eq token
    end
  end

  describe '#secret' do
    it 'retrieves the secret for the current user' do
      expect(user.secret('twitter')).to eq secret
    end
  end

  describe '#create_twitter_client' do
    context 'when the user has a Twitter provider' do
      it 'creates the Twitter client' do
        expect(user.create_twitter_client.class).to eq Twitter::Client
      end
    end

    context 'when the user does not have a Twitter provider' do
      it 'returns nil' do
        expect(user2.create_twitter_client).to eq nil
      end
    end
  end
end
