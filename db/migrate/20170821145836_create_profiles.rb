class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :main_diploma
      t.string :main_school
      t.string :main_school_major_topic
      t.string :main_school_grqduqtion_yeqr
      t.integer :nb_years_experience
      t.string :company_type
      t.string :company_industry
      t.integer :company_size
      t.string :job_type
      t.string :job_subtype
      t.string :job_location
      t.boolean :job_remote
      t.string :job_contract
      t.integer :job_min_salary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
