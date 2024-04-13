-- Create members table
CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    height FLOAT,
    weight FLOAT
);

-- Create trainers table
CREATE TABLE trainers (
    id SERIAL PRIMARY KEY
);

-- Create staffs table
CREATE TABLE staffs (
    id SERIAL PRIMARY KEY
);

-- Create availabilities table
CREATE TABLE availabilities (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    trainer_id BIGINT NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES trainers(id)
);

-- Create bills table
CREATE TABLE bills (
    id SERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    date DATE,
    paid BOOLEAN DEFAULT false,
    name VARCHAR(255),
    cost DECIMAL,
    FOREIGN KEY (member_id) REFERENCES members(id)
);

-- Create exercises table
CREATE TABLE exercises (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    has_weight BOOLEAN DEFAULT false,
    has_time BOOLEAN DEFAULT false,
    has_distance BOOLEAN DEFAULT false
);

-- Create exercise_routines table
CREATE TABLE exercise_routines (
    id SERIAL PRIMARY KEY,
    exercise_id BIGINT NOT NULL,
    repetitions INT NOT NULL,
    weight INT,
    time INT,
    distance INT,
    FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

-- Create rooms table
CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    maximum_occupancy INT
);

-- Create fitness_classes table
CREATE TABLE fitness_classes (
    id SERIAL PRIMARY KEY,
    room_id BIGINT NOT NULL,
    trainer_id BIGINT NOT NULL,
    group_session BOOLEAN DEFAULT false,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(id)
);

-- Create equipment table
CREATE TABLE equipment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    last_used DATE,
    last_maintained DATE
);

-- Create fitness_class_equipments table
CREATE TABLE fitness_class_equipments (
    id SERIAL PRIMARY KEY,
    fitness_class_id BIGINT NOT NULL,
    equipment_id BIGINT NOT NULL,
    FOREIGN KEY (fitness_class_id) REFERENCES fitness_classes(id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(id)
);

-- Create fitness_class_exercise_routines table
CREATE TABLE fitness_class_exercise_routines (
    id SERIAL PRIMARY KEY,
    fitness_class_id BIGINT NOT NULL,
    exercise_routine_id BIGINT NOT NULL,
    FOREIGN KEY (fitness_class_id) REFERENCES fitness_classes(id),
    FOREIGN KEY (exercise_routine_id) REFERENCES exercise_routines(id)
);

-- Create fitness_class_members table
CREATE TABLE fitness_class_members (
    id SERIAL PRIMARY KEY,
    fitness_class_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    FOREIGN KEY (fitness_class_id) REFERENCES fitness_classes(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);

-- Create fitness_goals table
CREATE TABLE fitness_goals (
    id SERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    exercise_id BIGINT NOT NULL,
    repetitions INT,
    weight INT,
    time INT,
    distance INT,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

-- Create completed_exercise_routines table
CREATE TABLE completed_exercise_routines (
    id SERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    exercise_routine_id BIGINT NOT NULL,
    date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (exercise_routine_id) REFERENCES exercise_routines(id)
);

-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL DEFAULT '',
    encrypted_password VARCHAR(255) NOT NULL DEFAULT '',
    reset_password_token VARCHAR(255) UNIQUE,
    reset_password_sent_at TIMESTAMP,
    remember_created_at TIMESTAMP,
    roleable_type VARCHAR(255),
    roleable_id BIGINT,
    UNIQUE(roleable_type, roleable_id)
);

-- Set up indexes (optional)
CREATE INDEX idx_availabilities_on_trainer_id ON availabilities(trainer_id);
CREATE INDEX idx_bills_on_member_id ON bills(member_id);
CREATE INDEX idx_exercise_routines_on_exercise_id ON exercise_routines(exercise_id);
CREATE INDEX idx_fitness_class_equipments_on_equipment_id ON fitness_class_equipments(equipment_id);
CREATE INDEX idx_fitness_class_equipments_on_fitness_class_id ON fitness_class_equipments(fitness_class_id);
CREATE INDEX idx_fitness_class_exercise_routines_on_exercise_routine_id ON fitness_class_exercise_routines(exercise_routine_id);
CREATE INDEX idx_fitness_class_exercise_routines_on_fitness_class_id ON fitness_class_exercise_routines(fitness_class_id);
CREATE INDEX idx_fitness_class_members_on_fitness_class_id ON fitness_class_members(fitness_class_id);
CREATE INDEX idx_fitness_class_members_on_member_id ON fitness_class_members(member_id);
CREATE INDEX idx_fitness_classes_on_room_id ON fitness_classes(room_id);
CREATE INDEX idx_fitness_classes_on_trainer_id ON fitness_classes(trainer_id);
CREATE INDEX idx_fitness_goals_on_exercise_id ON fitness_goals(exercise_id);
CREATE INDEX idx_fitness_goals_on_member_id ON fitness_goals(member_id);
CREATE INDEX idx_users_on_email ON users(email);
CREATE INDEX idx_users_on_reset_password_token ON users(reset_password_token);
CREATE INDEX idx_users_on_roleable ON users(roleable_type, roleable_id);
