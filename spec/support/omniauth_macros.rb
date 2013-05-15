module OmniauthMacros
  def mock_auth_twitter
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter] = {
        'provider' => 'twitter',
        'uid' => '123545',
        'user_info' => {
            'name' => 'mockuser',
            'image' => 'mock_user_thumbnail_url'
        },
        'credentials' => {
            'token' => 'mock_token',
            'secret' => 'mock_secret'
        }
    }
  end

  def mock_auth_hash
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
                                                                    'provider' => 'google_oauth2',
                                                                    'uid' => '103933682950854620224',
                                                                    'info' => {
                                                                        'name' => 'gSchool Test',
                                                                        'email' => 'gschooltest@gmail.com',
                                                                        'first_name' => 'gSchool',
                                                                        'last_name' => 'Test'
                                                                    },
                                                                    'credentials' => {
                                                                        'token' => 'ya29.AHES6ZSZ4i8z2BWHfRf4mJiuuq0QPy98R9JWjugOB2tyWYo',
                                                                        'refresh_token' => '1/GolcbSvsZqN8qz6mJFDvLY7VpioIo6uyUZRL4DAs22s'
                                                                    }
                                                                })
  end
end