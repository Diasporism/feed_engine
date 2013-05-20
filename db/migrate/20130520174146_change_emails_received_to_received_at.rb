class ChangeEmailsReceivedToReceivedAt < ActiveRecord::Migration
  def change
    remove_column :emails, :received
    add_column :emails, :received_at, :datetime
  end
end
