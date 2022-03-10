class OrderDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :post_code, :region_id,
                :city, :address, :building_name, :tel, :order_id

  #バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :post_code
    validates :region_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :address
    validates :tel
    validates :post_code
  end

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