class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :company_id
      t.string :title
      t.string :contract
      t.string :remote
      t.float :salary
      t.string :type
      t.string :subtype
      t.string :description
      t.string :profile
      t.boolean :open

      t.timestamps
    end
  end
end
