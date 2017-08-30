class ChangeProfileCompanySizeType < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :company_size, :string
  end
end
