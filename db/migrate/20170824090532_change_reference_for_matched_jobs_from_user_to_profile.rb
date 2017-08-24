class ChangeReferenceForMatchedJobsFromUserToProfile < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :matched_jobs, :users
  	remove_column :matched_jobs, :user_id
  	add_reference :matched_jobs, :profile
  end
end
