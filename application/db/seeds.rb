# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

### MEMBERS
Member.create(
  first_name: 'Member',
  last_name: 'One',
  date_of_birth: '1990-01-01',
  height: 180,
  weight: 80,
)
Member.create(
  first_name: 'Member',
  last_name: 'Two',
  date_of_birth: '1990-01-01',
  height: 180,
  weight: 80,
)
User.create(
  email: 'member1@domain.com',
  password: '123456',
  password_confirmation: '123456',
  roleable_type: 'Member',
  roleable_id: 1
)
User.create(
  email: 'member2@domain.com',
  password: '123456',
  password_confirmation: '123456',
  roleable_type: 'Member',
  roleable_id: 2
)

### TRAINERS
Trainer.create()
Trainer.create()
User.create(
  email: 'trainer1@domain.com',
  password: '123456',
  password_confirmation: '123456',
  roleable_type: 'Trainer',
  roleable_id: 1
)
User.create(
  email: 'trainer2@domain.com',
  password: '123456',
  password_confirmation: '123456',
  roleable_type: 'Trainer',
  roleable_id: 2
)

### STAFF
Staff.create()
Staff.create()
User.create(
  email: 'staff1@domain.com',
  password: '123456',
  password_confirmation: '123456',
  roleable_type: 'Staff',
  roleable_id: 1
)
User.create(
  email: 'staff2@domain.com',
  password: '123456',
  password_confirmation: '123456',
  roleable_type: 'Staff',
  roleable_id: 2
)

### ROOMS
Room.create(maximum_occupancy: 10)
Room.create(maximum_occupancy: 20)

### EQUIPMENT
Equipment.create(
  name: 'Dumbbell',
  last_used: '2021-01-01',
  last_maintained: '2023-01-01',
)
Equipment.create(
  name: 'Barbell',
  last_used: '2020-01-01',
  last_maintained: '2022-01-01',
)

### EXERCISES
Exercise.create(
  name: 'Bench Press',
  has_weight: true,
  has_time: false,
  has_distance: false,
)
Exercise.create(
  name: 'Treadmill',
  has_weight: false,
  has_time: true,
  has_distance: true,
)

### FITNESS GOALS
FitnessGoal.create(
  member_id: 1,
  exercise_id: 1,
  repetitions: 10,
  weight: 100,
  time: nil,
  distance: nil,
)
FitnessGoal.create(
  member_id: 2,
  exercise_id: 2,
  repetitions: 2,
  weight: nil,
  time: 30,
  distance: 5,
)

### EXERCISE ROUTINES
ExerciseRoutine.create(
  exercise_id: 1,
  repetitions: 10,
  weight: 100,
  time: nil,
  distance: nil,
)
ExerciseRoutine.create(
  exercise_id: 2,
  repetitions: 1,
  weight: nil,
  time: 30,
  distance: 5,
)

### COMPLETED EXERCISE ROUTINES
CompletedExerciseRoutine.create(
  member_id: 1,
  exercise_routine_id: 1,
  date: '2024-04-15',
)
CompletedExerciseRoutine.create(
  member_id: 2,
  exercise_routine_id: 2,
  date: '2024-04-15',
)

### FITNESS CLASSES
FitnessClass.create(
  room_id: 1,
  trainer_id: 1,
  group_session: true,
  start_time: '2024-04-15 10:00:00',
  end_time: '2024-04-15 11:00:00',
)
FitnessClass.create(
  room_id: 2,
  trainer_id: 2,
  group_session: false,
  start_time: '2024-04-15 12:00:00',
  end_time: '2024-04-15 13:00:00',
)

### FITNESS CLASS MEMBERS
FitnessClassMember.create(
  fitness_class_id: 1,
  member_id: 1,
)
FitnessClassMember.create(
  fitness_class_id: 2,
  member_id: 2,
)

### FITNESS CLASS EQUIPMENT
FitnessClassEquipment.create(
  fitness_class_id: 1,
  equipment_id: 1,
)
FitnessClassEquipment.create(
  fitness_class_id: 2,
  equipment_id: 2,
)

### FITNESS CLASS EXERCISE ROUTINES
FitnessClassExerciseRoutine.create(
  fitness_class_id: 1,
  exercise_routine_id: 1,
)
FitnessClassExerciseRoutine.create(
  fitness_class_id: 2,
  exercise_routine_id: 2,
)

puts 'Seeds created successfully!'