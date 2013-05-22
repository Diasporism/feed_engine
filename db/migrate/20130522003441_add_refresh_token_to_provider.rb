class AddRefreshTokenToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :refresh_token, :string
  end
end
