class AddColumnPositionToMotivationRanking < ActiveRecord::Migration[5.0]
  def change
  	add_column :motivation_rankings, :position, :integer
  end
end
