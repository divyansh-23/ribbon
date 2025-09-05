class AddDescriptionToDiagrams < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :description, :text
  end
end
