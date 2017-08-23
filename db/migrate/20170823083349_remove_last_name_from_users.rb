class RemoveLastNameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :last_name, :string
    remove_column :users, :headline, :string
    remove_column :users, :location, :string
    remove_column :users, :position, :string
    remove_column :users, :picture_url, :string
  end
end
