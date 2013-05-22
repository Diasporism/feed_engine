class ChangeBodyColumnToTextType < ActiveRecord::Migration
  def change
    change_column :emails, :body, :text, :limit => nil
  end
end
