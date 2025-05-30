require "test_helper"

class AffectationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get affectations_index_url
    assert_response :success
  end

  test "should get show" do
    get affectations_show_url
    assert_response :success
  end

  test "should get new" do
    get affectations_new_url
    assert_response :success
  end

  test "should get edit" do
    get affectations_edit_url
    assert_response :success
  end
end
