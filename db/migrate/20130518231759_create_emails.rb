class CreateEmails < ActiveRecord::Migration

  def change
    create_table :emails do |t|
      t.references :provider
      t.string :received
      t.string :from
      t.string :subject
      t.string :body
    end
    add_index :emails, :provider_id
  end
end
