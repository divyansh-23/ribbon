class AddLocalToDiagram < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :local, :boolean, :default => false
  end
end
