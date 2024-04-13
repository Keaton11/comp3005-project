class CreateCompletedExerciseRoutines < ActiveRecord::Migration[7.1]
  def change
    create_table :completed_exercise_routines do |t|
      t.references :member, null: false, foreign_key: true
      t.references :exercise_routine, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
