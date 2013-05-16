OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], authorize_params: {force_login: 'true'}
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    # { scope: 'https://mail.google.com/', access_type: 'offline' }
    { scope: "userinfo.email,userinfo.profile,https://mail.google.com" }
end