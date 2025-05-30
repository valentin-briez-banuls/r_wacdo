require "test_helper"

class FonctionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fonctions_index_url
    assert_response :success
  end

  test "should get show" do
    get fonctions_show_url
    assert_response :success
  end

  test "should get new" do
    get fonctions_new_url
    assert_response :success
  end

  test "should get edit" do
    get fonctions_edit_url
    assert_response :success
  end
end
