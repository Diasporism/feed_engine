class EmailFetcher
  @queue = :emails_queue

  def self.perform(args)
    puts 'Checking for emails'
    user = User.find(args['user_id'])
    gmail_client = user.create_imap_client
    Platform.connect_gmail(gmail_client, user)
    Platform.get_email(user)
    Resque.enqueue_in(1.minutes, EmailFetcher, :user_id => args['user_id'])
  end
end