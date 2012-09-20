class Event < ActiveRecord::Base
  attr_accessible :code, :description, :enddate, :playerid, :read, :startdate
  
 
 def mark_as_read
	update_attribute(:read, 1)
 end
 
  def self.mark_as_read(x)
	y = Event.find_by_id(x)
	y.read = 1
	y.save
 end
 
 
   def mark(x)
	update_attribute(:read, x)
	return x
  end
  
 def update_notification
	Notification.insert_new_record( id, code, 'events' ,  description , read  , playerid ,  1 , startdate ,enddate, '1900-01-01' , -2)
 end
 
   def push
   	@bulbs = Notification.where('playerid = ?' , playerid).sum('bulb')
      PN.publish({
        'channel' => 'rails',
        'message' => {"object"=> "event" , 'total_bulbs'=> @bulbs, "id"=> id , "code" => code , "description" => description , "enddate" => enddate , "playerid" => playerid, "startdate" => startdate , "read" => read}
      })
  end
 
end
