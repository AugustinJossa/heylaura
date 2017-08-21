class RemoveCompanyIdFromJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :company_id, :integer
  end
end
