class AddDownloadableToDiagrams < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :downloadable, :boolean, :default => false
  end
end
