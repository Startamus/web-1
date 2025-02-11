class Client < ApplicationRecord
  has_many :purchases, class_name: "Sale"
  has_many :items, through: :purchases
end
