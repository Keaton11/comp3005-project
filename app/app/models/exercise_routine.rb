class ExerciseRoutine < ApplicationRecord
  belongs_to :exercise
  has_many :fitness_class_exercise_routines
  has_many :fitness_classes, through: :fitness_class_exercise_routines
  has_many :completed_exercise_routines
end
