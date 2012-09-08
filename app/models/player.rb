class Player < ActiveRecord::Base
  attr_accessible :address, :clublevel, :contact, :encrypted_password, :encrypted_password_confirmation, :name, :playerid, :ptsBal, :ptsRed

  
  def self.get_player(playerid)
	@playernames = Player.where("playerid = ?" , playerid).select("name")
	@playernames.each do |p|
		return p.name
	end
	
	
  end
  
  
  validates_presence_of  :name , :playerid
  validates_uniqueness_of  :name , :playerid
  validates :encrypted_password, :presence => true,
					   :confirmation => true,
					   :length => {:within => 6..40},
					   :on => :create
  validates :encrypted_password, :confirmation => true,
					   :length => {:within => 6..40},
					   :allow_blank => true,
					   :on => :update


  before_save :encrypt_password
  

  
  


  def has_password?(submitted_password)
	encrypted_password == encrypt(submitted_password)
	

  end
  
  def self.authenticate(playerid, submitted_password)
	player = find_by_playerid(playerid)
	return nil if player.nil?
	#return player.encrypted_password if player.has_password?(submitted_password)
	return player if player.has_password?(submitted_password)
	
  end
	
 def self.authenticate_with_salt(playerid, cookie_salt)
    player = find_by_playerid(playerid)
    (player && player.salt == cookie_salt) ? player : nil
  end

  	def encrypt_password
      self.salt = make_salt unless has_password?(encrypted_password)
      self.encrypted_password = encrypt(encrypted_password)
    end
  
private


    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{encrypted_password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
					   
  
end

