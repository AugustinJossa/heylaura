class ChangeProfileJobRemoteType < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :job_remote, :string
  end
end
