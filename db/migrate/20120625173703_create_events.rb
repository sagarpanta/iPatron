class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :code
      t.string :description
      t.datetime :startdate
      t.datetime :enddate
      t.string :playerid
      t.integer :read

      t.timestamps
    end
  end
end
