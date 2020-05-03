class PaymentDetail < ApplicationRecord
  belongs_to :user

  validates :name, :card_number, :expiry, :cvv, presence: true
  validates :name, length: {in: 2..60}
  validates :cvv, numericality: {only_integer: true}
  validates :cvv, length: {is: 3}
  validates :card_number, numericality: {only_integer: true}, length: {is: 16}
  # validates :card_number, uniqueness: true  #Check whether it is needed
  validates :expiry, date: {after: Date.today}

end
