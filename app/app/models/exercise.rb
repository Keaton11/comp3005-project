class Exercise < ApplicationRecord
  has_many :fitness_goals
  has_many :exercise_routines
end
