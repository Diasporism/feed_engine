class PlatformController < ApplicationController

  before_filter :require_login, only: [:index]

  def index
    begin
      twitter_client = current_user.create_twitter_client

    user = User.find(session[:user_id])
    provider = Provider.find(session[:provider_id])
    @email = provider.email(user)
    #tweets = [{:created_at=>"Thu May 09 16:50:35 +0000 2013", :id=>332538096048558080, :id_str=>"332538096048558080", :text=>"I set my phaser to share - Star Trek Ipsum placeholder text http://t.co/oO51NJze0I", :source=>"<a href=\"http://twitter.com/tweetbutton\" rel=\"nofollow\">Tweet Button</a>", :truncated=>false, :in_reply_to_status_id=>nil, :in_reply_to_status_id_str=>nil, :in_reply_to_user_id=>nil, :in_reply_to_user_id_str=>nil, :in_reply_to_screen_name=>nil, :user=>{:id=>205086968, :id_str=>"205086968", :name=>"Erin Drummond", :screen_name=>"ebdrummond", :location=>"Denver, Colorado", :description=>"It's never too late to hit restart.", :url=>nil, :entities=>{:description=>{:urls=>[]}}, :protected=>false, :followers_count=>87, :friends_count=>114, :listed_count=>4, :created_at=>"Wed Oct 20 03:43:13 +0000 2010", :favourites_count=>26, :utc_offset=>-18000, :time_zone=>"Eastern Time (US & Canada)", :geo_enabled=>true, :verified=>false, :statuses_count=>240, :lang=>"en", :contributors_enabled=>false, :is_translator=>false, :profile_background_color=>"B2DFDA", :profile_background_image_url=>"http://a0.twimg.com/images/themes/theme13/bg.gif", :profile_background_image_url_https=>"https://si0.twimg.com/images/themes/theme13/bg.gif", :profile_background_tile=>false, :profile_image_url=>"http://a0.twimg.com/profile_images/1148490927/3380445817_e809cd636f_normal.jpg", :profile_image_url_https=>"https://si0.twimg.com/profile_images/1148490927/3380445817_e809cd636f_normal.jpg", :profile_link_color=>"93A644", :profile_sidebar_border_color=>"EEEEEE", :profile_sidebar_fill_color=>"FFFFFF", :profile_text_color=>"333333", :profile_use_background_image=>true, :default_profile=>false, :default_profile_image=>false, :following=>true, :follow_request_sent=>nil, :notifications=>nil}, :geo=>nil, :coordinates=>nil, :place=>nil, :contributors=>nil, :retweet_count=>0, :favorite_count=>0, :entities=>{:hashtags=>[], :symbols=>[], :urls=>[{:url=>"http://t.co/oO51NJze0I", :expanded_url=>"http://star-trek-ipsum.meetpollux.com", :display_url=>"star-trek-ipsum.meetpollux.com", :indices=>[60, 82]}], :user_mentions=>[]}, :favorited=>false, :retweeted=>false, :possibly_sensitive=>false, :lang=>"en"}, {:created_at=>"Thu May 09 16:30:38 +0000 2013", :id=>332533077966458882, :id_str=>"332533077966458882", :text=>"Building my Own Laptop http://t.co/YjCcTl7m26", :source=>"<a href=\"http://bufferapp.com\" rel=\"nofollow\">Buffer</a>", :truncated=>false, :in_reply_to_status_id=>nil, :in_reply_to_status_id_str=>nil, :in_reply_to_user_id=>nil, :in_reply_to_user_id_str=>nil, :in_reply_to_screen_name=>nil, :user=>{:id=>22386062, :id_str=>"22386062", :name=>"Steve Klabnik", :screen_name=>"steveklabnik", :location=>"Santa Monica", :description=>"The nomads are there, wherever there forms a smooth space ... The nomads inhabit these places; they remain in them, and they themselves make them grow.", :url=>"http://www.steveklabnik.com", :entities=>{:url=>{:urls=>[{:url=>"http://www.steveklabnik.com", :expanded_url=>nil, :indices=>[0, 27]}]}, :description=>{:urls=>[]}}, :protected=>false, :followers_count=>8590, :friends_count=>642, :listed_count=>631, :created_at=>"Sun Mar 01 18:00:55 +0000 2009", :favourites_count=>2999, :utc_offset=>-21600, :time_zone=>"Central Time (US & Canada)", :geo_enabled=>true, :verified=>false, :statuses_count=>62002, :lang=>"en", :contributors_enabled=>false, :is_translator=>false, :profile_background_color=>"1A1B1F", :profile_background_image_url=>"http://a0.twimg.com/images/themes/theme9/bg.gif", :profile_background_image_url_https=>"https://si0.twimg.com/images/themes/theme9/bg.gif", :profile_background_tile=>false, :profile_image_url=>"http://a0.twimg.com/profile_images/3618534654/13a7a0ab0ac4a621b26162282cafce32_normal.jpeg", :profile_image_url_https=>"https://si0.twimg.com/profile_images/3618534654/13a7a0ab0ac4a621b26162282cafce32_normal.jpeg", :profile_banner_url=>"https://pbs.twimg.com/profile_banners/22386062/1355689766", :profile_link_color=>"2FC2EF", :profile_sidebar_border_color=>"181A1E", :profile_sidebar_fill_color=>"252429", :profile_text_color=>"666666", :profile_use_background_image=>true, :default_profile=>false, :default_profile_image=>false, :following=>true, :follow_request_sent=>nil, :notifications=>nil}, :geo=>nil, :coordinates=>nil, :place=>nil, :contributors=>nil, :retweet_count=>0, :favorite_count=>4, :entities=>{:hashtags=>[], :symbols=>[], :urls=>[{:url=>"http://t.co/YjCcTl7m26", :expanded_url=>"http://buff.ly/119aT6t", :display_url=>"buff.ly/119aT6t", :indices=>[23, 45]}], :user_mentions=>[]}, :favorited=>false, :retweeted=>false, :possibly_sensitive=>false, :lang=>"en"}, {:created_at=>"Thu May 09 16:02:13 +0000 2013", :id=>332525927361830915, :id_str=>"332525927361830915", :text=>"US Census bureau: $70,794 personal income (top 10% of US population). We are the %10!!!!!!", :source=>"web", :truncated=>false, :in_reply_to_status_id=>nil, :in_reply_to_status_id_str=>nil, :in_reply_to_user_id=>nil, :in_reply_to_user_id_str=>nil, :in_reply_to_screen_name=>nil, :user=>{:id=>997444831, :id_str=>"997444831", :name=>"Xaca Xulu", :screen_name=>"XacaXulu", :location=>"", :description=>"Former Marine, Rubyist, Software Developer, Military Contractor, Runner and brother of @l4k3\r\nLooking for a RoR job in Germany/France/India", :url=>"http://t.co/iQSmR6s7i3", :entities=>{:url=>{:urls=>[{:url=>"http://t.co/iQSmR6s7i3", :expanded_url=>"http://gschool.it", :display_url=>"gschool.it", :indices=>[0, 22]}]}, :description=>{:urls=>[]}}, :protected=>false, :followers_count=>181, :friends_count=>173, :listed_count=>1, :created_at=>"Sat Dec 08 15:57:00 +0000 2012", :favourites_count=>101, :utc_offset=>-25200, :time_zone=>"Arizona", :geo_enabled=>true, :verified=>false, :statuses_count=>741, :lang=>"en", :contributors_enabled=>false, :is_translator=>false, :profile_background_color=>"1A1B1F", :profile_background_image_url=>"http://a0.twimg.com/images/themes/theme9/bg.gif", :profile_background_image_url_https=>"https://si0.twimg.com/images/themes/theme9/bg.gif", :profile_background_tile=>false, :profile_image_url=>"http://a0.twimg.com/profile_images/3468378415/5078dec2c4524be4f7b85849611ba545_normal.jpeg", :profile_image_url_https=>"https://si0.twimg.com/profile_images/3468378415/5078dec2c4524be4f7b85849611ba545_normal.jpeg", :profile_banner_url=>"https://si0.twimg.com/profile_banners/997444831/1355467153", :profile_link_color=>"2FC2EF", :profile_sidebar_border_color=>"181A1E", :profile_sidebar_fill_color=>"252429", :profile_text_color=>"666666", :profile_use_background_image=>true, :default_profile=>false, :default_profile_image=>false, :following=>true, :follow_request_sent=>nil, :notifications=>nil}, :geo=>nil, :coordinates=>nil, :place=>nil, :contributors=>nil, :retweet_count=>0, :favorite_count=>0, :entities=>{:hashtags=>[], :symbols=>[], :urls=>[], :user_mentions=>[]}, :favorited=>false, :retweeted=>false, :lang=>"en"}, {:created_at=>"Thu May 09 16:00:18 +0000 2013", :id=>332525443850833920, :id_str=>"332525443850833920", :text=>"Watching Wal-Mart at Midnight - why Wal*Mart stores fill up at 11pm on the last day of the month http://t.co/nHrFPNzG0F", :source=>"<a href=\"http://bufferapp.com\" rel=\"nofollow\">Buffer</a>", :truncated=>false, :in_reply_to_status_id=>nil, :in_reply_to_status_id_str=>nil, :in_reply_to_user_id=>nil, :in_reply_to_user_id_str=>nil, :in_reply_to_screen_name=>nil, :user=>{:id=>22386062, :id_str=>"22386062", :name=>"Steve Klabnik", :screen_name=>"steveklabnik", :location=>"Santa Monica", :description=>"The nomads are there, wherever there forms a smooth space ... The nomads inhabit these places; they remain in them, and they themselves make them grow.", :url=>"http://www.steveklabnik.com", :entities=>{:url=>{:urls=>[{:url=>"http://www.steveklabnik.com", :expanded_url=>nil, :indices=>[0, 27]}]}, :description=>{:urls=>[]}}, :protected=>false, :followers_count=>8590, :friends_count=>642, :listed_count=>631, :created_at=>"Sun Mar 01 18:00:55 +0000 2009", :favourites_count=>2999, :utc_offset=>-21600, :time_zone=>"Central Time (US & Canada)", :geo_enabled=>true, :verified=>false, :statuses_count=>62002, :lang=>"en", :contributors_enabled=>false, :is_translator=>false, :profile_background_color=>"1A1B1F", :profile_background_image_url=>"http://a0.twimg.com/images/themes/theme9/bg.gif", :profile_background_image_url_https=>"https://si0.twimg.com/images/themes/theme9/bg.gif", :profile_background_tile=>false, :profile_image_url=>"http://a0.twimg.com/profile_images/3618534654/13a7a0ab0ac4a621b26162282cafce32_normal.jpeg", :profile_image_url_https=>"https://si0.twimg.com/profile_images/3618534654/13a7a0ab0ac4a621b26162282cafce32_normal.jpeg", :profile_banner_url=>"https://si0.twimg.com/profile_banners/22386062/1355689766", :profile_link_color=>"2FC2EF", :profile_sidebar_border_color=>"181A1E", :profile_sidebar_fill_color=>"252429", :profile_text_color=>"666666", :profile_use_background_image=>true, :default_profile=>false, :default_profile_image=>false, :following=>true, :follow_request_sent=>nil, :notifications=>nil}, :geo=>nil, :coordinates=>nil, :place=>nil, :contributors=>nil, :retweet_count=>1, :favorite_count=>2, :entities=>{:hashtags=>[], :symbols=>[], :urls=>[{:url=>"http://t.co/nHrFPNzG0F", :expanded_url=>"http://buff.ly/1168iKE", :display_url=>"buff.ly/1168iKE", :indices=>[97, 119]}], :user_mentions=>[]}, :favorited=>false, :retweeted=>false, :possibly_sensitive=>false, :lang=>"en"}]
    tweets = twitter_client.home_timeline if twitter_client
    @twitter_timeline = tweets
  rescue
    #go back to twitter and ask the user to re-authorize
    #grab the new token/secret on the way back from omniauth
    #update that users provider with the new token
    #try again
  end

  def splash
    @params = params
    render :layout => false
  end
end
