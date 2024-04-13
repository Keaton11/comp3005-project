class RemoveTimestampsFromBills < ActiveRecord::Migration[7.1]
  def change
    remove_column :bills, :created_at, :datetime
    remove_column :bills, :updated_at, :datetime
  end
end
