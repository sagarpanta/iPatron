class Offer < ActiveRecord::Base
  attr_accessible :code, :description, :enddate, :playerid, :startdate , :read

  

 def mark_as_read
	update_attribute(:read, 1)
 end
 
  def self.mark_as_read(x)
	y = Offer.find_by_id(x)
	y.read = 1
	y.save
 end
 
 def update_notification
	Notification.insert_new_record( id, code, 'offers' ,  description , read  , playerid ,  1 , startdate ,enddate, '1900-01-01' , -2)
 end
 
end
