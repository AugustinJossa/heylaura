class AddReferencesToJobSkills < ActiveRecord::Migration[5.0]
  def change
  	add_reference :required_skills, :job, foreign_key: true
  end
end
