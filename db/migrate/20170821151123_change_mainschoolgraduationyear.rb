class ChangeMainschoolgraduationyear < ActiveRecord::Migration[5.0]
  def change
  	rename_column :profiles, :main_school_grqduqtion_yeqr, :main_school_graduation_year
  end
end
