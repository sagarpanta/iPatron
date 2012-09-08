module SessionsHelper
  def sign_in(player)
    cookies.permanent.signed[:remember_token] = [player.playerid, player.salt]
    current_player = player
  end
  

  
  
  def sign_out
    current_player = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_player.nil?
  end
  
  def current_player=(player)
    @current_player = player
  end
  
  def current_player
    @current_player ||= player_from_remember_token
  end
  
  
 
  
  private

	
    def player_from_remember_token
      Player.authenticate_with_salt(*remember_token) #*=use [] instead of 2 vars
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end	

end
