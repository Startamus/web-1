require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "it has many sales" do
    assert_respond_to Item.new, :sales
  end
end
