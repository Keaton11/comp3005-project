require "test_helper"

class FitnessClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fitness_class = fitness_classes(:one)
  end

  test "should get index" do
    get fitness_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_fitness_class_url
    assert_response :success
  end

  test "should create fitness_class" do
    assert_difference("FitnessClass.count") do
      post fitness_classes_url, params: { fitness_class: { end_time: @fitness_class.end_time, group_session: @fitness_class.group_session, room_id: @fitness_class.room_id, start_time: @fitness_class.start_time, trainer_id: @fitness_class.trainer_id } }
    end

    assert_redirected_to fitness_class_url(FitnessClass.last)
  end

  test "should show fitness_class" do
    get fitness_class_url(@fitness_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_fitness_class_url(@fitness_class)
    assert_response :success
  end

  test "should update fitness_class" do
    patch fitness_class_url(@fitness_class), params: { fitness_class: { end_time: @fitness_class.end_time, group_session: @fitness_class.group_session, room_id: @fitness_class.room_id, start_time: @fitness_class.start_time, trainer_id: @fitness_class.trainer_id } }
    assert_redirected_to fitness_class_url(@fitness_class)
  end

  test "should destroy fitness_class" do
    assert_difference("FitnessClass.count", -1) do
      delete fitness_class_url(@fitness_class)
    end

    assert_redirected_to fitness_classes_url
  end
end
