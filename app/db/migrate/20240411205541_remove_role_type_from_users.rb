class RemoveRoleTypeFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :role_type, :enum, enum_type: "role_type_enum"
    execute <<-SQL
      DROP TYPE role_type_enum;
    SQL
  end
end
