require "application_system_test_case"

class FitnessGoalsTest < ApplicationSystemTestCase
  setup do
    @fitness_goal = fitness_goals(:one)
  end

  test "visiting the index" do
    visit fitness_goals_url
    assert_selector "h1", text: "Fitness goals"
  end

  test "should create fitness goal" do
    visit fitness_goals_url
    click_on "New fitness goal"

    fill_in "Distance", with: @fitness_goal.distance
    fill_in "Exercise", with: @fitness_goal.exercise_id
    fill_in "Member", with: @fitness_goal.member_id
    fill_in "Repetitions", with: @fitness_goal.repetitions
    fill_in "Time", with: @fitness_goal.time
    fill_in "Weight", with: @fitness_goal.weight
    click_on "Create Fitness goal"

    assert_text "Fitness goal was successfully created"
    click_on "Back"
  end

  test "should update Fitness goal" do
    visit fitness_goal_url(@fitness_goal)
    click_on "Edit this fitness goal", match: :first

    fill_in "Distance", with: @fitness_goal.distance
    fill_in "Exercise", with: @fitness_goal.exercise_id
    fill_in "Member", with: @fitness_goal.member_id
    fill_in "Repetitions", with: @fitness_goal.repetitions
    fill_in "Time", with: @fitness_goal.time
    fill_in "Weight", with: @fitness_goal.weight
    click_on "Update Fitness goal"

    assert_text "Fitness goal was successfully updated"
    click_on "Back"
  end

  test "should destroy Fitness goal" do
    visit fitness_goal_url(@fitness_goal)
    click_on "Destroy this fitness goal", match: :first

    assert_text "Fitness goal was successfully destroyed"
  end
end
