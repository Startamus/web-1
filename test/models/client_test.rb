require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "it has many purchases" do
    assert_respond_to Client.new, :purchases
  end

  test "it has many items" do
    assert_respond_to Client.new, :items
  end
end
