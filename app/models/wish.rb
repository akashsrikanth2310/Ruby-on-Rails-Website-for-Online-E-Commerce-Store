class Wish < ApplicationRecord
  has_many :wish_items, dependent: :destroy
  has_many :items, through: :wish_items
end
