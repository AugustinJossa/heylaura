class CreateMotivationRankings < ActiveRecord::Migration[5.0]
  def change
    create_table :motivation_rankings do |t|
      t.references :motivation_category, foreign_key: true
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
