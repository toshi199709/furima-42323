class Order < ApplicationRecord
  validates :price, presence: true
  attr_accessor :price
end
