class RemoveTimestampsFromExerciseRoutines < ActiveRecord::Migration[7.1]
  def change
    remove_column :exercise_routines, :created_at, :datetime
    remove_column :exercise_routines, :updated_at, :datetime
  end
end
