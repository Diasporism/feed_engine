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

      xit 'creates a user account' do
        @request.env['omniauth.auth'] = google_omniauth_env
        post :create
        user = User.find_by_email(google_email)
        expect(user.email).to eq google_email
      end

      it 'the user is logged in' do
        @request.env['omniauth.auth'] = google_omniauth_env
        post :create
        user = User.find_by_email(google_email)
        expect(user).to be
        expect(controller.current_user).to eq user
      end

      context 'when the user already has already has an account' do

        it 'two users are not created' do
          @request.env['omniauth.auth'] = google_omniauth_env
          post :create
          post :create
          user = User.find_all_by_email(google_email)
          expect(user.size).to eq 1
        end
      end
    end
  end
end