class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.float :location_lat
      t.float :location_lng
      t.string :type
      t.string :industry
      t.integer :size
      t.string :description
      t.string :logo
      t.string :picture
      t.integer :user_id

      t.timestamps
    end
  end
end
