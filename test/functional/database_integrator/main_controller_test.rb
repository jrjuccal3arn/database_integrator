require 'test_helper'

class DatabaseIntegrator::MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
