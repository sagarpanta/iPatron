class Promotion < ActiveRecord::Base
  attr_accessible :code, :description, :drawingtime, :endate, :num_of_entries, :playerid, :read, :startdate
  
  
  
 def mark_as_read
	update_attribute(:read, 1)
 end
 
  def self.mark_as_read(x)
	y = Promotion.find_by_id(x)
	y.read = 1
	y.save
 end

 
 def update_notification
	Notification.insert_new_record( id, code, 'promotions' ,  description , read  , playerid ,  1 , startdate ,endate, drawingtime , num_of_entries)
 end
 
   def push
      @bulbs = Notification.where('playerid = ?' , playerid).sum('bulb')
      PN.publish({
        'channel' => 'rails',
        'message' => {"object"=> "promotion" , 'total_bulbs'=> @bulbs, "id"=> id , "code" => code , "description" => description , "drawingtime"=>drawingtime, "num_of_entries"=>num_of_entries, "endate" => endate , "playerid" => playerid, "startdate" => startdate , "read" => read}
      })
  end
 
end
