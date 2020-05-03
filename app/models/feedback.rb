class Feedback < ApplicationRecord
  validates :name, :email, :comments, presence: true
end
