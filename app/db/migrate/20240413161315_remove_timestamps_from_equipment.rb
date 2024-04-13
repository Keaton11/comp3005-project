class RemoveTimestampsFromEquipment < ActiveRecord::Migration[7.1]
  def change
    remove_column :equipment, :created_at, :datetime
    remove_column :equipment, :updated_at, :datetime
  end
end
