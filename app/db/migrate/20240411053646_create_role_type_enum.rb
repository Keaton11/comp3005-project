class CreateRoleTypeEnum < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE role_type_enum AS ENUM ('Member', 'Trainer', 'Staff');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE role_type_enum;
    SQL
  end
end
