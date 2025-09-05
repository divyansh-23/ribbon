class AddShareWithAllInstitutions < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :share_with_all_institutions, :boolean, :default => false
  end
end
