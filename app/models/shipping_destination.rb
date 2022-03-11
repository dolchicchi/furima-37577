class ShippingDestination < ApplicationRecord
  # アソシエーション
  belongs_to :order
end
