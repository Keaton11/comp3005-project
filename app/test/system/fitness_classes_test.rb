require "application_system_test_case"

class FitnessClassesTest < ApplicationSystemTestCase
  setup do
    @fitness_class = fitness_classes(:one)
  end

  test "visiting the index" do
    visit fitness_classes_url
    assert_selector "h1", text: "Fitness classes"
  end

  test "should create fitness class" do
    visit fitness_classes_url
    click_on "New fitness class"

    fill_in "End time", with: @fitness_class.end_time
    check "Group session" if @fitness_class.group_session
    fill_in "Room", with: @fitness_class.room_id
    fill_in "Start time", with: @fitness_class.start_time
    fill_in "Trainer", with: @fitness_class.trainer_id
    click_on "Create Fitness class"

    assert_text "Fitness class was successfully created"
    click_on "Back"
  end

  test "should update Fitness class" do
    visit fitness_class_url(@fitness_class)
    click_on "Edit this fitness class", match: :first

    fill_in "End time", with: @fitness_class.end_time
    check "Group session" if @fitness_class.group_session
    fill_in "Room", with: @fitness_class.room_id
    fill_in "Start time", with: @fitness_class.start_time
    fill_in "Trainer", with: @fitness_class.trainer_id
    click_on "Update Fitness class"

    assert_text "Fitness class was successfully updated"
    click_on "Back"
  end

  test "should destroy Fitness class" do
    visit fitness_class_url(@fitness_class)
    click_on "Destroy this fitness class", match: :first

    assert_text "Fitness class was successfully destroyed"
  end
end
