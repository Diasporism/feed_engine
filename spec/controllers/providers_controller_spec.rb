require 'spec_helper'

describe ProvidersController do
  let(:user) { User.create(email: 'lsears322@gmail.com') }
  let(:current_user) { controller.current_user }
  let(:twitter_name) { 'Logan Sears' }
  let(:twitter_provider_name) { 'twitter' }
  let(:twitter_uid) { '438712211' }
  let(:twitter_omniauth_env) do
    {
        'provider' => twitter_provider_name,
        'uid' => twitter_uid,
        'info' => {
            'name' => twitter_name,
        },
        'credentials' => {
            'token' => '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY',
            'secret' => 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV0'
        }
    }
  end

  describe '#create' do
    it 'creates a provider associated with current user' do
      @request.env['omniauth.auth'] = twitter_omniauth_env
      controller.auto_login(user)
      post :create
      expect(current_user.providers.first.name).to eq twitter_provider_name
      expect(current_user.providers.first.uid).to eq twitter_uid
      expect(current_user.providers.first.user_id).to eq current_user.id
    end

    it 'will not create duplicate providers for a user' do
      @request.env['omniauth.auth'] = twitter_omniauth_env
      controller.auto_login(user)
      post :create
      post :create
      providers = Provider.find_all_by_uid(twitter_uid)
      expect(providers.size).to eq 1
    end
  end

  describe '#destroy' do
    it 'deletes the correct provider associated with a user' do
      @request.env['omniauth.auth'] = twitter_omniauth_env
      controller.auto_login(user)
      post :create
      expect(current_user.providers.size).to eq 1
      post :destroy, id: current_user.providers.first
      expect(current_user.providers.size).to eq 0
    end
  end
end