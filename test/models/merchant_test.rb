require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test "it has many sales" do
    assert_respond_to Merchant.new, :sales
  end
end
