class AddBulbToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :bulb, :integer
  end
end
