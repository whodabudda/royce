require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get doc" do
    get welcome_doc_url
    assert_response :success
  end

  test "should get about" do
    get welcome_about_url
    assert_response :success
  end

  test "should get home" do
    get welcome_home_url
    assert_response :success
  end

  test "should get set_local_session_tz" do
    get welcome_set_local_session_tz_url
    assert_response :success
  end

  test "should get filter_by_tag" do
    get welcome_filter_by_tag_url
    assert_response :success
  end

end
