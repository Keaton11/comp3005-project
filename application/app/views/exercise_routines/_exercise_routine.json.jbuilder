json.extract! exercise_routine, :id, :exercise_id, :repetitions, :weight, :time, :distance, :created_at, :updated_at
json.url exercise_routine_url(exercise_routine, format: :json)
