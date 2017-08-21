class CreateRequiredSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :required_skills do |t|
      t.text :comment
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
