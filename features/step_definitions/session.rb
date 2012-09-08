
Given /the player "(.*)" has an account$/ do |id|
	@player = Player.create!({:address => 'some address' , :clublevel => 'some club' , :encrypted_password => '123456' , :encrypted_password_confirmation => '123456' , :name => 'John Doe' , :playerid => id , :ptsBal => 1254 , :ptsRed => 4521})
end

When /he logs in$/ do
	login(@player.playerid, @player.encrypted_password)
end

Then /he should see "Welcome (.*)"$/ do |name|
	@player.name.should == name

end




Given /the player "(.*)" is logged in$/ do |playerid|
	@player = Player.create!({:address => 'some address' , :clublevel => 'some club' , :encrypted_password => '123456' , :encrypted_password_confirmation => '123456' , :name => 'John Doe' , :playerid =>  playerid, :ptsBal => 1254 , :ptsRed => 4521})
	login(@player.playerid, @player.encrypted_password)

end



Given /he is in player home page$/ do 
	visit('/player_home')
end


Given /he has some (.*)$/ do |items|
	if items =='offers'
			@offer = Offer.create!({:code => '1111' , :description => 'this is test' , :enddate => '9/1/2012' , :playerid => '101', :startdate => '9/1/2012' , :read => 0 })
	elsif items == 'events'
			@event = Event.create!({:code => '1111' , :description => 'this is test' , :enddate => '9/1/2012' , :playerid => '101', :startdate => '9/1/2012' , :read => 0 })
	end
end


When /he clicks on the (.*) tab$/ do |item|
	if item == 'offer'
		click_link(".player_home")
	elsif item == 'event'
		_count = Event.where("playerid = ?", @player.playerid).count
		assert _count.should == Event.count
	end
end



Then /he should see the (.*) ordered by created date$/ do |item|
	if item == 'offer'
		_count = Offer.where("playerid = ?", @player.playerid).count
		assert _count.should == Offer.count
	elsif item == 'event'
		_count = Event.where("playerid = ?", @player.playerid).count
		assert _count.should == Event.count
	end

end


