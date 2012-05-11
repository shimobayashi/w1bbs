require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get create_message" do
    get :create_message
    assert_response :success
  end

end
