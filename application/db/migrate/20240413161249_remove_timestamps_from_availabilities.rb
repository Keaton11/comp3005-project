class RemoveTimestampsFromAvailabilities < ActiveRecord::Migration[7.1]
  def change
    remove_column :availabilities, :created_at, :datetime
    remove_column :availabilities, :updated_at, :datetime
  end
end
