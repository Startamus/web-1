class Sale < ApplicationRecord
  belongs_to :item
  belongs_to :merchant
  belongs_to :client

  before_save :denormalize_total

  def self.create_from_sales_data_row!(data)
    item_params = data[:item]
    merchant_params = data[:merchant]
    client_params = data[:client]

    ActiveRecord::Base.transaction do
      item = Item.find_or_create_by!(item_params)
      merchant = Merchant.find_or_create_by!(merchant_params)
      client = Client.find_or_create_by!(client_params)

      sale_params = data[:sale].merge(item:, merchant:, client:)
      sale = Sale.create!(sale_params.merge)

      return sale.total
    end

  end

  private

  def denormalize_total
    self.total = quantity * price
  end

end
