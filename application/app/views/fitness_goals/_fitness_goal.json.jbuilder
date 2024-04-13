json.extract! fitness_goal, :id, :member_id, :exercise_id, :repetitions, :weight, :time, :distance, :created_at, :updated_at
json.url fitness_goal_url(fitness_goal, format: :json)
