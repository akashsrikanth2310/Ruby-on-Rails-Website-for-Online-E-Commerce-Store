class Order < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_one :return_item, dependent: :destroy
end
