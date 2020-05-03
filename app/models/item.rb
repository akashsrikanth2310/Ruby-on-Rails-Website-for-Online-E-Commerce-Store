class Item < ApplicationRecord
  validates :category, case_sensitive:false
  validates :brand, case_sensitive:false
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :wish_items, dependent: :destroy
end

