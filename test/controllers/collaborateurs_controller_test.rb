require "test_helper"

class CollaborateursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collaborateurs_index_url
    assert_response :success
  end

  test "should get show" do
    get collaborateurs_show_url
    assert_response :success
  end

  test "should get new" do
    get collaborateurs_new_url
    assert_response :success
  end

  test "should get edit" do
    get collaborateurs_edit_url
    assert_response :success
  end
end
