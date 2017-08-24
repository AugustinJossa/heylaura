class AddProfileForeignKeytoMatchedJobs < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :matched_jobs, :profiles
  end
end
