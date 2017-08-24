class AddInfoToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :first_name, :string
    add_column :profiles, :session_info, :integer
    add_column :profiles, :raw_chat_content, :text
    add_column :profiles, :i, :integer
    add_column :profiles, :icomp, :integer
    add_column :profiles, :ijob, :integer
    add_column :profiles, :iprofile, :integer
    add_column :profiles, :iaspir, :integer
  end
end
