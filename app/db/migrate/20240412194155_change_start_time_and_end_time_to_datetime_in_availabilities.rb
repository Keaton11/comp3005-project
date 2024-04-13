class ChangeStartTimeAndEndTimeToDatetimeInAvailabilities < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      ALTER TABLE availabilities
      ALTER COLUMN start_time TYPE timestamp without time zone
      USING timestamp '2000-01-01' + start_time;
    SQL

    execute <<-SQL
      ALTER TABLE availabilities
      ALTER COLUMN end_time TYPE timestamp without time zone
      USING timestamp '2000-01-01' + end_time;
    SQL
  end

  def down
    change_column :availabilities, :start_time, :time
    change_column :availabilities, :end_time, :time
  end
end
