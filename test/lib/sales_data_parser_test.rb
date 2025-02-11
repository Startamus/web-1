require "test_helper"

class SalesDataParserTest < ActiveSupport::TestCase
  def parser
    SalesDataParser.new("test/fixtures/example_input.tab")
  end

  test "it has a parse method" do
    assert_respond_to parser, :parse
  end

  test "it returns an array" do
    assert_instance_of Array, parser.parse
  end

  test "it returns an array of hashes" do
    assert_instance_of Hash, parser.parse.first
  end

  test "it returns an array of hashes with the correct keys" do
    assert_equal %i[client merchant item sale], parser.parse.first.keys
  end

  test "parses" do
    expected_result = [
      {
        client: {
          name: "João Silva"
        },
        merchant: {
          address: "987 Fake St",
          name: "Bob's Pizza"
        },
        item: {
          description: "Pepperoni Pizza Slice",
        },
        sale: {
          price: "10.0", #price moved here b/c of "Cute T-Shirt",
          quantity: "2",
        }
      },
      {
        client: {
          name: "Amy Pond"
        },
        merchant: {
          address: "456 Unreal Rd",
          name: "Tom's Awesome Shop"
        },
        item: {
          description: "Cute T-Shirt",
        },
        sale: {
          quantity: "5",
          price: "10.0",
        }
      },
      {
        client: {
          name: "Marty McFly"
        },
        merchant: {
          address: "123 Fake St",
          name: "Sneaker Store Emporium"
        },
        item: {
          description: "Cool Sneakers",
        },
        sale: {
          quantity: "1",
          price: "5.0",
        }
      },
      {
        client: {
          name: "Snake Plissken"
        },
        merchant: {
          address: "123 Fake St",
          name: "Sneaker Store Emporium"
        },
        item: {
          description: "Cool Sneakers",
        },
        sale: {
          quantity: "4",
          price: "5.0",
        }
      },
      {
        client: {
          name: "João Silva"
        },
        merchant: {
          address: "456 Unreal Rd",
          name: "Tom's Awesome Shop"
        },
        item: {
          description: "Cute T-Shirt",
        },
        sale: {
          quantity: "1",
          price: "7.95",
        }
      }
    ]

    parser_result = parser.parse

    expected_result.each_with_index { |e,i| 
      assert_equal parser_result[i], e
    }
  end
end
