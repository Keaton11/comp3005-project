require "test_helper"

class CompletedExerciseRoutinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @completed_exercise_routine = completed_exercise_routines(:one)
  end

  test "should get index" do
    get completed_exercise_routines_url
    assert_response :success
  end

  test "should get new" do
    get new_completed_exercise_routine_url
    assert_response :success
  end

  test "should create completed_exercise_routine" do
    assert_difference("CompletedExerciseRoutine.count") do
      post completed_exercise_routines_url, params: { completed_exercise_routine: { date: @completed_exercise_routine.date, exercise_routine_id: @completed_exercise_routine.exercise_routine_id, member_id: @completed_exercise_routine.member_id } }
    end

    assert_redirected_to completed_exercise_routine_url(CompletedExerciseRoutine.last)
  end

  test "should show completed_exercise_routine" do
    get completed_exercise_routine_url(@completed_exercise_routine)
    assert_response :success
  end

  test "should get edit" do
    get edit_completed_exercise_routine_url(@completed_exercise_routine)
    assert_response :success
  end

  test "should update completed_exercise_routine" do
    patch completed_exercise_routine_url(@completed_exercise_routine), params: { completed_exercise_routine: { date: @completed_exercise_routine.date, exercise_routine_id: @completed_exercise_routine.exercise_routine_id, member_id: @completed_exercise_routine.member_id } }
    assert_redirected_to completed_exercise_routine_url(@completed_exercise_routine)
  end

  test "should destroy completed_exercise_routine" do
    assert_difference("CompletedExerciseRoutine.count", -1) do
      delete completed_exercise_routine_url(@completed_exercise_routine)
    end

    assert_redirected_to completed_exercise_routines_url
  end
end
