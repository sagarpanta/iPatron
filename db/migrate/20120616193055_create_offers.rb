class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :code
      t.string :playerid
      t.datetime :startdate
      t.datetime :enddate
      t.string :description
	  t.integer :read

      t.timestamps
    end
  end
end
