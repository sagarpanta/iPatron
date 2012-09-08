class SessionsController < ApplicationController
 
  def new
  end

  def create
	#@password = Player.authenticate(params[:session][:playerid], params[:session][:password])
	#render '/players/test'
	
	player = Player.find_by_playerid(params[:session][:playerid])
	if player && Player.authenticate(params[:session][:playerid], params[:session][:password])
		if signed_in?
			redirect_to player_home_path
		else
			sign_in player
			redirect_to player_home_path
		end
	else 
		flash[:error] = 'Invalid email/password combination'
		render 'new'
	end

  end

  def destroy
    sign_out
    redirect_to signin_path
  end
  
end
