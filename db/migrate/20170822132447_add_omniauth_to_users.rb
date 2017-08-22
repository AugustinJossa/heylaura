class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :linkedink_picture_url, :string
    add_column :users, :last_name, :string
    add_column :users, :email_address, :string
    add_column :users, :headline, :string
    add_column :users, :location, :string
    add_column :users, :positions, :string
    add_column :users, :public_profil_url, :string
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
