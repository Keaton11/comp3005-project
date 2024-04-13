require "test_helper"

class FitnessGoalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fitness_goal = fitness_goals(:one)
  end

  test "should get index" do
    get fitness_goals_url
    assert_response :success
  end

  test "should get new" do
    get new_fitness_goal_url
    assert_response :success
  end

  test "should create fitness_goal" do
    assert_difference("FitnessGoal.count") do
      post fitness_goals_url, params: { fitness_goal: { distance: @fitness_goal.distance, exercise_id: @fitness_goal.exercise_id, member_id: @fitness_goal.member_id, repetitions: @fitness_goal.repetitions, time: @fitness_goal.time, weight: @fitness_goal.weight } }
    end

    assert_redirected_to fitness_goal_url(FitnessGoal.last)
  end

  test "should show fitness_goal" do
    get fitness_goal_url(@fitness_goal)
    assert_response :success
  end

  test "should get edit" do
    get edit_fitness_goal_url(@fitness_goal)
    assert_response :success
  end

  test "should update fitness_goal" do
    patch fitness_goal_url(@fitness_goal), params: { fitness_goal: { distance: @fitness_goal.distance, exercise_id: @fitness_goal.exercise_id, member_id: @fitness_goal.member_id, repetitions: @fitness_goal.repetitions, time: @fitness_goal.time, weight: @fitness_goal.weight } }
    assert_redirected_to fitness_goal_url(@fitness_goal)
  end

  test "should destroy fitness_goal" do
    assert_difference("FitnessGoal.count", -1) do
      delete fitness_goal_url(@fitness_goal)
    end

    assert_redirected_to fitness_goals_url
  end
end
