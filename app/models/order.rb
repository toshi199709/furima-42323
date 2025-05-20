class Order < ApplicationRecord
  attr_accessor :token

  belongs_to :user
  belongs_to :item

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number
    validates :token
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }
end
