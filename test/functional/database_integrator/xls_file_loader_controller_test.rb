require 'test_helper'

class DatabaseIntegrator::XlsFileLoaderControllerTest < ActionController::TestCase
  test "should get load_file" do
    get :load_file
    assert_response :success
  end

end
