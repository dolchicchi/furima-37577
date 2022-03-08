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
    validates :name
    validates :explanation
    validates :price
    validates :image
  end
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :region_id
    validates :days_required_id
  end
end
