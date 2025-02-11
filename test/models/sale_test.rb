require "test_helper"

class SaleTest < ActiveSupport::TestCase
  test "it belongs to a merchant" do
    assert_respond_to Sale.new, :merchant
  end

  test "it belongs to an item" do
    assert_respond_to Sale.new, :item
  end

  test "it belongs to a client" do
    assert_respond_to Sale.new, :client
  end

  test "it validates presence of price" do
    sale = Sale.new(quantity: 2)
    refute sale.valid?
    assert sale.errors[:price].present?
  end

  test "it validates presence of quantity" do
    sale = Sale.new(price: 3.50)
    refute sale.valid?
    assert sale.errors[:quantity].present?
  end

  test "it denormalizes total on save" do
    item = Item.create! description: "Item"
    merchant = Merchant.create! name: "Merchant"
    client = Client.create! name: "Client"

    sale = Sale.create!(quantity: 2, price: 3.50, item: item, merchant: merchant, client: client)
    assert_equal 7.00, sale.total
    sale.quantity = 3
    sale.save
    assert_equal 10.50, sale.total
  end

  test "creates from a hash obtained through SalesDataParser" do
    row_data = {
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
        price: 10.0,
        quantity: 2,
      },
      total: 20.0
    }

    assert_equal 0, Client.count
    assert_equal 0, Item.count
    assert_equal 0, Merchant.count

    Sale.create_from_sales_data_row!(row_data)

    assert_equal 1, Sale.count
    assert_equal 1, Client.count
    assert_equal 1, Item.count
    assert_equal 1, Merchant.count
  end

  test "creating from a hash obtained through SalesDataParser has transaction" do
    row_data = {
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
      },
      total: 0.0
    }

    assert_equal 0, Client.count
    assert_equal 0, Item.count
    assert_equal 0, Merchant.count

    assert_raises {
      Sale.create_from_sales_data_row!(row_data)
    }
    assert_equal 0, Sale.count
    assert_equal 0, Client.count
    assert_equal 0, Item.count
    assert_equal 0, Merchant.count
  end

  test "deduplicates client, item, merchant from a hash obtained through SalesDataParser" do
    row_data = {
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
        price: 10.0,
        quantity: 2,
      },
      total: 20.0
    }

    Item.create! row_data[:item]
    Client.create! row_data[:client]
    Merchant.create! row_data[:merchant]

    assert_equal 1, Client.count
    assert_equal 1, Item.count
    assert_equal 1, Merchant.count

    Sale.create_from_sales_data_row!(row_data)

    assert_equal 1, Client.count
    assert_equal 1, Item.count
    assert_equal 1, Merchant.count

    row_data2 = row_data.clone
    row_data2[:merchant][:address] = "Different 123"
    Sale.create_from_sales_data_row!(row_data2)

    assert_equal 1, Client.count
    assert_equal 1, Item.count
    assert_equal 2, Merchant.count
  end

end
