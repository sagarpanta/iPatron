class AddPlayeridToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :playerid, :string
  end
  
  def self.down
	remove_column :notifications, :playerid
  end
end
