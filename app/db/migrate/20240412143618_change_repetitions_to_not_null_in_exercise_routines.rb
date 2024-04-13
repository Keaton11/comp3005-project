class ChangeRepetitionsToNotNullInExerciseRoutines < ActiveRecord::Migration[7.1]
  def change
    change_column_null :exercise_routines, :repetitions, false
  end
end
