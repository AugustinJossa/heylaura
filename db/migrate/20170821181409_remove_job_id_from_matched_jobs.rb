class RemoveJobIdFromMatchedJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :matched_jobs, :job_id, :integer
  end
end
