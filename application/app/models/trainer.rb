class Trainer < ApplicationRecord
    has_many :availabilities
    has_many :fitness_classes
end
