class AddDoNotMailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :do_not_mail, :boolean, :default => false
  end
end
