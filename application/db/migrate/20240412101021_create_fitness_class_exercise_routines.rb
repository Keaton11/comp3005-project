class CreateFitnessClassExerciseRoutines < ActiveRecord::Migration[7.1]
  def change
    create_table :fitness_class_exercise_routines do |t|
      t.references :fitness_class, null: false, foreign_key: true
      t.references :exercise_routine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
