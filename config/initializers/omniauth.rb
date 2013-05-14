OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], authorize_params: {force_login: 'true'}
  provider :google_oauth2, '68178475741.apps.googleusercontent.com', '7zJk9eMKxCIJytHu96Gn4ydI'
end