class AddShareWithAllToDiagrams < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :share_with_all, :boolean, :default => false
  end
end
