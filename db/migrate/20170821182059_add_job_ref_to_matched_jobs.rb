class AddJobRefToMatchedJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :matched_jobs, :job, foreign_key: true
  end
end
