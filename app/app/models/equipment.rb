class Equipment < ApplicationRecord
  has_many :fitness_class_equipments
  has_many :fitness_classes, through: :fitness_class_equipments
end
