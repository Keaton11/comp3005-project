class RemovePrecisionFromStartTimeAndEndTimeInAvailabilities < ActiveRecord::Migration[7.1]
  def change
    change_column :availabilities, :start_time, :datetime
    change_column :availabilities, :end_time, :datetime
  end
end
