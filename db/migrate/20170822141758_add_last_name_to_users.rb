class AddLastNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_name, :string
    add_column :users, :headline, :string
    add_column :users, :location, :string
    add_column :users, :position, :string
    add_column :users, :picture_url, :string
  end
end
