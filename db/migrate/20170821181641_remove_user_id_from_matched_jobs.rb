class RemoveUserIdFromMatchedJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :matched_jobs, :user_id, :integer
  end
end
