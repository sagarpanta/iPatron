class AddSaltToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :salt, :string
  end
  
  def self.down
	remove_column :players, :salt
  end
end
