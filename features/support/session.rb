
module LoginSteps
	def login(playerid, password)
		visit('/signin')
		fill_in('session[playerid]' , :with => playerid)
		fill_in('session[password]' , :with => password)
		click_button('Sign In')
	end
end

World(LoginSteps)