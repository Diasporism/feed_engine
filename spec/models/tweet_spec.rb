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
    [{ :created_at=>"Sat May 18 20:02:13 +0000 2013", :id_str=>"335847813726482432", :text=>"refactor all the things!", :user=>{:screen_name=>"ecoffey", :profile_image_url=>"http://a0.twimg.com/profile_images/2781291847/a95f057eaa758be7cf2e4e9dadb383dc_normal.png"} },
     { :created_at=>"Fri May 17 20:02:13 +0000 2013", :id_str=>"325847813726482432", :text=>"test all the things!", :user=>{:screen_name=>"diasporism", :profile_image_url=>"http://si0.twimg.com/profile_images/3193921429/a62c2ab2733a666bb7dc41913b4f3b1c_bigger.jpeg"} }]
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
end

