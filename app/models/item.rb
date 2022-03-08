class Item < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :region
  belongs_to :days_required

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :explanation
    validates :price, 
      numericality: { 
        other_than: 0, 
        message: 'is invalid. Input half-width characters'}
  end
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :region_id
    validates :days_required_id
  end
  validates :price, 
    numericality: { 
      greater_than_or_equal_to: 300, 
      less_than_or_equal_to: 9999999,
      message: "is out of setting range"}
end