require 'spec_helper'

describe Tweet do

  let(:token)     { '438712211-PtqdV9KrNBpb4a6dRqAzUb2e7dyoXetJOyhua9MY' }
  let(:secret)    { 'tRNJ3mTpksSa6XNM8WgJ1SFdIauwpuWCeTdD33WXV0' }
  let(:user)      { User.create(email: 'lsears322@gmail.com') }
  let!(:provider) { user.providers.create(name: 'twitter',
                                          uid: 438712211,
                                          token: token,
                                          secret: secret) }
  let(:tweets) do
    [{ :created_at=>"Sat May 18 20:02:13 +0000 2013", :id=>335847813726482432, :text=>"refactor all the things!", :user=>{:screen_name=>"ecoffey", :profile_image_url=>"http://a0.twimg.com/profile_images/2781291847/a95f057eaa758be7cf2e4e9dadb383dc_normal.png"} },
     { :created_at=>"Fri May 17 20:02:13 +0000 2013", :id=>325847813726482431, :text=>"test all the things!", :user=>{:screen_name=>"diasporism", :profile_image_url=>"http://si0.twimg.com/profile_images/3193921429/a62c2ab2733a666bb7dc41913b4f3b1c_bigger.jpeg"} }]
  end

  let(:twitter_client) {user.create_twitter_client}

  describe '.save_tweets' do
    it 'saves individual tweets to the database as they come in' do
      expect(Tweet.all.count).to eq 0
      Tweet.save_tweets(user, tweets)
      expect(Tweet.all.count).to eq 2
    end
  end

  describe '.check_for_tweets' do
    it 'checks for new tweets from twitter based on the latest tweet the user has in the database' do
      Tweet.save_tweets(user, tweets)
      tweet_id = Tweet.order('received_at DESC').first.tweet_id
      expect(tweet_id).to eq "335847813726482432"

      expect(Tweet.all.count).to eq 2
      Tweet.check_for_tweets(user, twitter_client, tweet_id)
      expect(Tweet.all.count).to_not eq 2
    end
  end

  describe '.format_time' do
    context 'When difference is less than a minute' do
      it "returns 'Just now'" do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-05-20T17:51:51+00:00'))
        tweet_time = DateTime.parse('Mon, 20 May 2013 17:50:55 UTC +00:00')
        expect(Tweet.format_time(tweet_time)).to eq 'Just now'
      end
    end

    context 'When the difference is less than an hour but great than a minute' do
      it "returns '[minutes] minutes ago'" do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-05-20T17:59:51+00:00'))
        tweet_time = DateTime.parse('Mon, 20 May 2013 17:55:55 UTC +00:00')
        expect(Tweet.format_time(tweet_time)).to eq '3 minutes ago'
      end
    end

    context 'When the difference is less than a day but at least an hour' do
      it "returns '[hours] hours ago'" do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-05-20T19:55:51+00:00'))
        tweet_time = DateTime.parse('Mon, 20 May 2013 17:55:55 UTC +00:00')
        expect(Tweet.format_time(tweet_time)).to eq '1 hour ago'
      end
    end

    context 'When the difference is a day or more' do
      it 'returns the date it was published' do
        DateTime.stub_chain(:now, :new_offset).and_return(DateTime.parse('2013-08-20T17:59:51+00:00'))
        tweet_time = DateTime.parse('Mon, 20 May 2013 17:55:55 UTC +00:00')
        expect(Tweet.format_time(tweet_time)).to eq '20 May'
      end
    end
  end
end

