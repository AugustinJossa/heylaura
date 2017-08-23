class AddUserRefToMatchedJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :matched_jobs, :user, foreign_key: true
  end
end
