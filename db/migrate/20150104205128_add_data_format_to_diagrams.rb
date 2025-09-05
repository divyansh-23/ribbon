class AddDataFormatToDiagrams < ActiveRecord::Migration[5.2]
  def change
    add_column :diagrams, :data_format, :string
  end
end
