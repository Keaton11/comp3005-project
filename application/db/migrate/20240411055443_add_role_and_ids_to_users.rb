class AddRoleAndIdsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role_type, :role_type_enum, null: false
    add_column :users, :member_id, :integer
    add_column :users, :trainer_id, :integer
    add_column :users, :staff_id, :integer
  end
end
