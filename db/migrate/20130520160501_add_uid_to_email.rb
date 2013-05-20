class AddUidToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :uid, :string
  end
end
