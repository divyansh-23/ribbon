class CreateUserLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_logs do |t|
      t.references :user, foreign_key: true
      t.references :diagram, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
