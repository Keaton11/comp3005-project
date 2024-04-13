require "application_system_test_case"

class CompletedExerciseRoutinesTest < ApplicationSystemTestCase
  setup do
    @completed_exercise_routine = completed_exercise_routines(:one)
  end

  test "visiting the index" do
    visit completed_exercise_routines_url
    assert_selector "h1", text: "Completed exercise routines"
  end

  test "should create completed exercise routine" do
    visit completed_exercise_routines_url
    click_on "New completed exercise routine"

    fill_in "Date", with: @completed_exercise_routine.date
    fill_in "Exercise routine", with: @completed_exercise_routine.exercise_routine_id
    fill_in "Member", with: @completed_exercise_routine.member_id
    click_on "Create Completed exercise routine"

    assert_text "Completed exercise routine was successfully created"
    click_on "Back"
  end

  test "should update Completed exercise routine" do
    visit completed_exercise_routine_url(@completed_exercise_routine)
    click_on "Edit this completed exercise routine", match: :first

    fill_in "Date", with: @completed_exercise_routine.date
    fill_in "Exercise routine", with: @completed_exercise_routine.exercise_routine_id
    fill_in "Member", with: @completed_exercise_routine.member_id
    click_on "Update Completed exercise routine"

    assert_text "Completed exercise routine was successfully updated"
    click_on "Back"
  end

  test "should destroy Completed exercise routine" do
    visit completed_exercise_routine_url(@completed_exercise_routine)
    click_on "Destroy this completed exercise routine", match: :first

    assert_text "Completed exercise routine was successfully destroyed"
  end
end
