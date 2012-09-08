class Notification < ActiveRecord::Base
  attr_accessible :code, :description, :notification, :notificationid , :read
  

  
   def mark_as_read
	update_attribute(:read, 1)
   end
   
   def self.mark_as_read(playerid, notificationid, notification)
	notification = Notification.where('playerid=? and notificationid=? and notification=?',playerid, notificationid, notification)
	notification[0].read = 1
	notification[0].save
   end
   
   def set_bulb_to_zero
		update_attribute(:bulb, 0)
   end
   
   def self.insert_new_record(id, code, notification, description, read, playerid, bulb, startdate, enddate, drawingtime, num_of_entries)

		@notification = Notification.new
		@notification.notificationid = id
		@notification.code = code
		@notification.notification = notification
		@notification.description = description
		@notification.read = read
		@notification.playerid = playerid
		@notification.bulb = bulb
		@notification.startdate = startdate
		@notification.endate = enddate
		@notification.drawingtime = drawingtime
		@notification.num_of_entries = num_of_entries
		@notification.save
   end
  
end
