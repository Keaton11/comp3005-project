json.extract! exercise_routine, :id, :exercise_id, :repetitions, :weight, :time, :distance
json.url exercise_routine_url(exercise_routine, format: :json)
