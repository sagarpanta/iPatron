class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :code
      t.string :playerid
      t.datetime :startdate
      t.datetime :endate
      t.string :description
      t.datetime :drawingtime
      t.integer :num_of_entries
      t.integer :read

      t.timestamps
    end
  end
end
