class CreateUserDiagrams < ActiveRecord::Migration[5.2]
  def change
    create_table :user_diagrams do |t|
      t.belongs_to :user, :index => true
      t.belongs_to :diagram, :index => true

      t.timestamps
    end
  end
end
