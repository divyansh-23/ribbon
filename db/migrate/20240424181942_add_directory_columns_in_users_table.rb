class AddDirectoryColumnsInUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid_number, :integer
  end
end
