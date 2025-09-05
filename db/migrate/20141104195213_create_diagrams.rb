class CreateDiagrams < ActiveRecord::Migration[5.2]
  def change
    create_table :diagrams do |t|
      t.belongs_to :institution, :index => true
      t.integer :creator_id, :null => false
      t.string :name
      t.string :category
      t.timestamps
    end
  end
end
