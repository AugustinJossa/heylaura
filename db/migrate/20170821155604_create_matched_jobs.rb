class CreateMatchedJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :matched_jobs do |t|
      t.float :matching
      t.string :status
      t.text :message
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
