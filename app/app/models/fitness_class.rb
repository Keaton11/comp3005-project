class FitnessClass < ApplicationRecord
  belongs_to :room
  belongs_to :trainer
  has_many :fitness_class_members, dependent: :destroy
  has_many :members, through: :fitness_class_members
  has_many :fitness_class_equipments, dependent: :destroy
  has_many :equipment, through: :fitness_class_equipments
  has_many :fitness_class_exercise_routines, dependent: :destroy
  has_many :routines, through: :fitness_class_exercise_routines

  def import_details
    {
      fitness_class: self,
      equipment: self.fitness_class_equipments.joins(:equipment).select("equipment.*"),
      exercise_routines: self.fitness_class_exercise_routines.joins(:exercise_routine).select("exercise_routines.*"),
      member_count: self.fitness_class_members.count
    }
  end
end
