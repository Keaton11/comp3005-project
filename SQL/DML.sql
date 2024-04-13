-- Reset ID sequences
SELECT setval('members_id_seq', 1, false);
SELECT setval('trainers_id_seq', 1, false);
SELECT setval('staffs_id_seq', 1, false);
SELECT setval('rooms_id_seq', 1, false);
SELECT setval('equipment_id_seq', 1, false);
SELECT setval('exercises_id_seq', 1, false);
SELECT setval('fitness_goals_id_seq', 1, false);
SELECT setval('exercise_routines_id_seq', 1, false);
SELECT setval('completed_exercise_routines_id_seq', 1, false);
SELECT setval('fitness_classes_id_seq', 1, false);
SELECT setval('fitness_class_members_id_seq', 1, false);
SELECT setval('fitness_class_equipments_id_seq', 1, false);
SELECT setval('fitness_class_exercise_routines_id_seq', 1, false);
SELECT setval('users_id_seq', 1, false);

-- Insert Members
INSERT INTO members (first_name, last_name, date_of_birth, height, weight) VALUES
('Member', 'One', '1990-01-01', 180, 80),
('Member', 'Two', '1990-01-01', 180, 80);

-- Insert Users for Members
-- Note: Hashed passwords should first be generated using Devise
INSERT INTO users (email, encrypted_password, roleable_type, roleable_id) VALUES
('member1@domain.com', 'hashed_password_here', 'Member', 1),
('member2@domain.com', 'hashed_password_here', 'Member', 2);

-- Insert Trainers
INSERT INTO trainers VALUES (DEFAULT), (DEFAULT);

-- Insert Users for Trainers
-- Note: Hashed passwords should first be generated using Devise
INSERT INTO users (email, encrypted_password, roleable_type, roleable_id) VALUES
('trainer1@domain.com', 'hashed_password_here', 'Trainer', 1),
('trainer2@domain.com', 'hashed_password_here', 'Trainer', 2);

-- Insert Staff
INSERT INTO staffs VALUES (DEFAULT), (DEFAULT);

-- Insert Users for Staff
-- Note: Hashed passwords should first be generated using Devise
INSERT INTO users (email, encrypted_password, roleable_type, roleable_id) VALUES
('staff1@domain.com', 'hashed_password_here', 'Staff', 1),
('staff2@domain.com', 'hashed_password_here', 'Staff', 2);

-- Insert Rooms
INSERT INTO rooms (maximum_occupancy) VALUES
(10),
(20);

-- Insert Equipment
INSERT INTO equipment (name, last_used, last_maintained) VALUES
('Dumbbell', '2021-01-01', '2023-01-01'),
('Barbell', '2020-01-01', '2022-01-01');

-- Insert Exercises
INSERT INTO exercises (name, has_weight, has_time, has_distance) VALUES
('Bench Press', true, false, false),
('Treadmill', false, true, true);

-- Insert Fitness Goals
INSERT INTO fitness_goals (member_id, exercise_id, repetitions, weight, time, distance) VALUES
(1, 1, 10, 100, NULL, NULL),
(2, 2, 2, NULL, 30, 5);

-- Insert Exercise Routines
INSERT INTO exercise_routines (exercise_id, repetitions, weight, time, distance) VALUES
(1, 10, 100, NULL, NULL),
(2, 1, NULL, 30, 5);

-- Insert Completed Exercise Routines
INSERT INTO completed_exercise_routines (member_id, exercise_routine_id, date) VALUES
(1, 1, '2024-04-15'),
(2, 2, '2024-04-15');

-- Insert Fitness Classes
INSERT INTO fitness_classes (room_id, trainer_id, group_session, start_time, end_time) VALUES
(1, 1, true, '2024-04-15 10:00:00', '2024-04-15 11:00:00'),
(2, 2, false, '2024-04-15 12:00:00', '2024-04-15 13:00:00');

-- Insert Fitness Class Members
INSERT INTO fitness_class_members (fitness_class_id, member_id) VALUES
(1, 1),
(2, 2);

-- Insert Fitness Class Equipment
INSERT INTO fitness_class_equipments (fitness_class_id, equipment_id) VALUES
(1, 1),
(2, 2);

-- Insert Fitness Class Exercise Routines
INSERT INTO fitness_class_exercise_routines (fitness_class_id, exercise_routine_id) VALUES
(1, 1),
(2, 2);
