class WishItem < ApplicationRecord
  belongs_to :item
  belongs_to :wish
end
