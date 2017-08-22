class CorrectLinkedinPicture < ActiveRecord::Migration[5.0]
  def change
  	rename_column :users, :linkedink_picture_url, :linkedin_picture_url
  end
end
