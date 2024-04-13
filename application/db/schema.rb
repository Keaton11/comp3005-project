# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_13_161441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "trainer_id", null: false
    t.index ["trainer_id"], name: "index_availabilities_on_trainer_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.date "date"
    t.boolean "paid", default: false
    t.string "name"
    t.decimal "cost"
    t.index ["member_id"], name: "index_bills_on_member_id"
  end

  create_table "completed_exercise_routines", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "exercise_routine_id", null: false
    t.date "date"
    t.index ["exercise_routine_id"], name: "index_completed_exercise_routines_on_exercise_routine_id"
    t.index ["member_id"], name: "index_completed_exercise_routines_on_member_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.date "last_used"
    t.date "last_maintained"
  end

  create_table "exercise_routines", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.integer "repetitions", null: false
    t.integer "weight"
    t.integer "time"
    t.integer "distance"
    t.index ["exercise_id"], name: "index_exercise_routines_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.boolean "has_weight", default: false
    t.boolean "has_time", default: false
    t.boolean "has_distance", default: false
  end

  create_table "fitness_class_equipments", force: :cascade do |t|
    t.bigint "fitness_class_id", null: false
    t.bigint "equipment_id", null: false
    t.index ["equipment_id"], name: "index_fitness_class_equipments_on_equipment_id"
    t.index ["fitness_class_id"], name: "index_fitness_class_equipments_on_fitness_class_id"
  end

  create_table "fitness_class_exercise_routines", force: :cascade do |t|
    t.bigint "fitness_class_id", null: false
    t.bigint "exercise_routine_id", null: false
    t.index ["exercise_routine_id"], name: "index_fitness_class_exercise_routines_on_exercise_routine_id"
    t.index ["fitness_class_id"], name: "index_fitness_class_exercise_routines_on_fitness_class_id"
  end

  create_table "fitness_class_members", force: :cascade do |t|
    t.bigint "fitness_class_id", null: false
    t.bigint "member_id", null: false
    t.index ["fitness_class_id"], name: "index_fitness_class_members_on_fitness_class_id"
    t.index ["member_id"], name: "index_fitness_class_members_on_member_id"
  end

  create_table "fitness_classes", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "trainer_id", null: false
    t.boolean "group_session", default: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["room_id"], name: "index_fitness_classes_on_room_id"
    t.index ["trainer_id"], name: "index_fitness_classes_on_trainer_id"
  end

  create_table "fitness_goals", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "repetitions"
    t.integer "weight"
    t.integer "time"
    t.integer "distance"
    t.index ["exercise_id"], name: "index_fitness_goals_on_exercise_id"
    t.index ["member_id"], name: "index_fitness_goals_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.float "height"
    t.float "weight"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "maximum_occupancy"
  end

  create_table "staffs", force: :cascade do |t|
  end

  create_table "trainers", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "roleable_type"
    t.bigint "roleable_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["roleable_type", "roleable_id"], name: "index_users_on_roleable"
  end

  add_foreign_key "availabilities", "trainers"
  add_foreign_key "bills", "members"
  add_foreign_key "completed_exercise_routines", "exercise_routines"
  add_foreign_key "completed_exercise_routines", "members"
  add_foreign_key "exercise_routines", "exercises"
  add_foreign_key "fitness_class_equipments", "equipment"
  add_foreign_key "fitness_class_equipments", "fitness_classes"
  add_foreign_key "fitness_class_exercise_routines", "exercise_routines"
  add_foreign_key "fitness_class_exercise_routines", "fitness_classes"
  add_foreign_key "fitness_class_members", "fitness_classes"
  add_foreign_key "fitness_class_members", "members"
  add_foreign_key "fitness_classes", "rooms"
  add_foreign_key "fitness_classes", "trainers"
  add_foreign_key "fitness_goals", "exercises"
  add_foreign_key "fitness_goals", "members"
end
