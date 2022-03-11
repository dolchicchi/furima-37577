class OrderDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :post_code, :region_id,
                :city, :address, :building_name, :tel, :order_id

  #バリデーション
  validates :region_id, numericality: {other_than: 1, message: "can't be blank"}

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :post_code, format: {
      with: /\A\d{3}[-]\d{4}\z/,
      message: "is invalid. Enter it as follows(e.g 123-4567)"
    }
    validates :city
    validates :address
    validates :tel
  end
  validates :tel, numericality: {
    only_integer: true,
    message: 'is invalid. Input only number'
  }
  validates :tel, numericality: {
    length: { minmum: 10, maximum: 11 },
    message: 'is too short'
  }

  def save
    order = Order.create(
      user_id: user_id, item_id: item_id,
      token: token
    )

    shipping_destination = ShippingDestination.create(
      post_code: post_code, region_id: region_id, city: city, building_name: building_name, 
      address: address, tel: tel, post_code: post_code, order_id: order.id)
  end
end