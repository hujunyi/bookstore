require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'label', /\$[,\d]+\.\d\d/
  end

end
