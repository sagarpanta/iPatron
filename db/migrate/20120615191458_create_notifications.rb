class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notificationid
      t.string :code
      t.string :notification
      t.string :description
	  t.integer :read

      t.timestamps
    end
  end
end
