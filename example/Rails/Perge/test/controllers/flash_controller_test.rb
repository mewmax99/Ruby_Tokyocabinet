require 'test_helper'

class FlashControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flash_index_url
    assert_response :success
  end

end
