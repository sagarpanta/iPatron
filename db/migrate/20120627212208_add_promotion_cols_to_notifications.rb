class AddPromotionColsToNotifications < ActiveRecord::Migration
  def change
	add_column :notifications, :startdate, :datetime
	add_column :notifications, :endate, :datetime
	add_column :notifications, :drawingtime, :datetime
	add_column :notifications, :num_of_entries, :integer
  end
end
