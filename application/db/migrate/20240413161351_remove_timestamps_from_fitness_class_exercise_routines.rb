class RemoveTimestampsFromFitnessClassExerciseRoutines < ActiveRecord::Migration[7.1]
  def change
    remove_column :fitness_class_exercise_routines, :created_at, :datetime
    remove_column :fitness_class_exercise_routines, :updated_at, :datetime
  end
end
