class RemoveTimestampsFromMembers < ActiveRecord::Migration[7.1]
  def change
    remove_column :members, :created_at, :datetime
    remove_column :members, :updated_at, :datetime
  end
end
