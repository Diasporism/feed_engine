class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :provider
      t.string :tweet_id
      t.string :text
      t.string :screen_name
      t.string :profile_image_url
      t.datetime :received_at

      t.timestamps
    end
    add_index :tweets, :provider_id
  end
end
