class RemoveTimestampsFromRooms < ActiveRecord::Migration[7.1]
  def change
    remove_column :rooms, :created_at, :datetime
    remove_column :rooms, :updated_at, :datetime
  end
end
