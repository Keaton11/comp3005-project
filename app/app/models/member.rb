class Member < ApplicationRecord
  after_create :create_bill
  has_one :user, as: :roleable

  has_many :fitness_goals
  has_many :completed_exercise_routines
  has_many :fitness_class_members
  has_many :fitness_classes, through: :fitness_class_members
  has_many :bills

  def create_bill
    self.bills.create(name: "Membership Fee", cost: 100, date: Date.today, paid: false)
  end
end
