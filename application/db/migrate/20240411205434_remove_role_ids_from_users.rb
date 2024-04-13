class RemoveRoleIdsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :member_id, :integer
    remove_column :users, :trainer_id, :integer
    remove_column :users, :staff_id, :integer
  end
end
