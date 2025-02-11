require 'csv'

class SalesDataParser
  def initialize(file_path)
    @path = file_path
  end

  def parse
    arr = []

    CSV.foreach(@path, col_sep: "\t", headers: true) do |row|
      purchaser_name = row[0]
      item_description = row[1]
      item_price = row[2]
      purchase_count = row[3]
      merchant_address = row[4]
      merchant_name = row[5]

      arr << {
        client: {
          name: purchaser_name
        },
        merchant: {
          name: merchant_name,
          address: merchant_address
        },
        item: {
          description: item_description
        },
        sale: {
          quantity: purchase_count,
          price: item_price
        }
      }
    end

    arr
  end
end
