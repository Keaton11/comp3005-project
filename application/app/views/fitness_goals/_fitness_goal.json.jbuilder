json.extract! fitness_goal, :id, :member_id, :exercise_id, :repetitions, :weight, :time, :distance
json.url fitness_goal_url(fitness_goal, format: :json)
