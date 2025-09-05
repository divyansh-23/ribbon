class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :message, :null => false
      t.boolean :admin_only, :default => false
      t.timestamps :null => false
    end
  end
end
