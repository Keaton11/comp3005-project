class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.integer :maximum_occupancy

      t.timestamps
    end
  end
end
