class RemoveTimestampsFromStaffs < ActiveRecord::Migration[7.1]
  def change
    remove_column :staffs, :created_at, :datetime
    remove_column :staffs, :updated_at, :datetime
  end
end
