require "test_helper"

class SalesDataControllerTest < ActionDispatch::IntegrationTest
 
  test "GET root => SalesData#index" do
    assert_routing({method: 'get', path: '/'}, {controller: 'sales_data', action: 'index'})
  end

  test "root oks" do
    get '/'
    assert_response :success
  end

  test "POST root => SalesData#create" do
    assert_routing({method: 'post', path: '/'}, {controller: 'sales_data', action: 'create'})
  end

  test "POST root with file" do
    file = fixture_file_upload('example_input.tab')
    post '/', params: {sales_data: file}

    assert_response :success
  end
end
