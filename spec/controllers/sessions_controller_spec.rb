require 'spec_helper'

describe SessionsController do

  context 'When a user is not logged in' do
    context 'and they authenticate with Google' do

      let(:google_email) { 'gschooltest@gmail.com' }
      let(:google_first_name) { 'gSchool' }
      let(:google_last_name) { 'Test' }
      let(:google_provider_name) { 'google_oauth2' }
      let(:google_uid) { '103933682950854620224' }

      let(:google_omniauth_env) do
        {
            'provider' => google_provider_name,
            'uid' => google_uid,
            'info' => {
                'name' => "#{google_first_name} #{google_last_name}",
                'email' => google_email,
                'first_name' => google_first_name,
                'last_name' => google_last_name
            },
            'credentials' => {
                'token' => 'ya29.AHES6ZSZ4i8z2BWHfRf4mJiuuq0QPy98R9JWjugOB2tyWYo',
                'refresh_token' => '1/GolcbSvsZqN8qz6mJFDvLY7VpioIo6uyUZRL4DAs22s'
            }
        }
      end

      let(:twitter_name) { 'Logan Sears' }
      let(:twitter_provider_name) { 'twitter' }
      let(:twitter_uid) { '438712211' }
      let(:twitter_omniauth_env) do
        {
            'provider' => twitter_name,
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

      let(:twitter_name2) { 'Logan Sears2' }
      let(:twitter_provider_name2) { 'twitter' }
      let(:twitter_uid2) { '4387122112' }
      let(:twitter_omniauth_env2) do
        {
            'provider' => twitter_name2,
            'uid' => twitter_uid2,
            'info' => {
                'name' => twitter_name2,
            },
            'credentials' => {
                'token' => '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY2',
                'secret' => 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV02'
            }
        }
      end

      it 'creates a user account' do
        @request.env['omniauth.auth'] = google_omniauth_env
        post :create
        user = User.find_by_email(google_email)
        expect(user.email).to eq google_email
      end

      it 'the user account has a google provider' do
        @request.env['omniauth.auth'] = google_omniauth_env
        post :create
        user = User.find_by_email(google_email)
        provider = user.providers.first
        expect(provider.name).to eq google_provider_name
        expect(provider.uid).to eq google_uid
      end

      it 'the user is logged in' do
        @request.env['omniauth.auth'] = google_omniauth_env
        post :create

        user = User.find_by_email(google_email)

        expect(user).to be
        expect(controller.current_user).to eq user

        #find a way to test that the redirect after login works
        #current_url = request.url
        #expect(current_url).to eq '/'
      end


      context 'when the user already has already has an account' do
        it 'two users are not created' do
          @request.env['omniauth.auth'] = google_omniauth_env
          post :create

          @request.env['omniauth.auth'] = google_omniauth_env
          post :create

          user = User.find_all_by_email(google_email)

          expect(user.size).to eq 1
        end

        it 'updates provider information if it has changed' do
          #setup: login with gmail account and add twitter
          @request.env['omniauth.auth'] = google_omniauth_env
          post :create
          @request.env['omniauth.auth'] = twitter_omniauth_env
          post :create

          #destroy providers by provider type
          controller.current_user.providers.delete

          #action
          @request.env['omniauth.auth'] = twitter_omniauth_env2
          post :create

          #assertion
          #check that the new twitter is attached to the current user and the old one is not
          user = controller.current_user
          expect(controller.current_user.providers.where(name: 'twitter').size).to eq 1
          expect(user.providers.where(name: 'twitter').first.uid).to eq '4387122112'
        end
      end

    end

  end

  context 'when the user is logged in' do
    context 'and they authenticate with twitter' do
      it 'adds the twitter provider to the user'
      it 'updates provider information if it has changed'
    end


  end

end