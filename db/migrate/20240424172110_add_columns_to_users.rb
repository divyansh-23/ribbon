class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :why_give_access, :text
    add_column :users, :how_did_you_learn_about, :text
  end
end
