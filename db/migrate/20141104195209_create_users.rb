class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :institution, :index => true
      t.boolean :super_admin, :default => false
      t.string :name

      t.timestamps
    end
  end
end
