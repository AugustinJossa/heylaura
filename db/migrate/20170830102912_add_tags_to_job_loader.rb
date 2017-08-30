class AddTagsToJobLoader < ActiveRecord::Migration[5.0]
  def change
    add_column :job_loaders, :ctype, :string
    add_column :job_loaders, :cindustry, :string
    add_column :job_loaders, :csize, :string
    add_column :job_loaders, :jexperience, :integer
    add_column :job_loaders, :jtype, :string
    add_column :job_loaders, :jsubtype, :string
    add_column :job_loaders, :jlocation, :string
    add_column :job_loaders, :jcontract, :string
    add_column :job_loaders, :jremote, :string
    add_column :job_loaders, :jsalary, :integer

  end
end
