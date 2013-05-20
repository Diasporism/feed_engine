class ChangeReceivedAtToDateTimeForTweet < ActiveRecord::Migration
  def change
    change_column(:tweets, :received_at, :datetime)
  end
end
