class AddLastUsedInfoToDiagrams < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :last_used_by_id, :integer
    add_column :diagrams, :last_used_at, :datetime
  end
end
