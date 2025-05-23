class OrderAddress
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Conversion
  extend ActiveModel::Naming # ← form_withにmodel名を認識させる！

  attr_accessor :postal_code, :prefecture_id, :city, :address, :building,
                :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :address
    validates :phone_number
    validates :token
    validates :user_id
    validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

  # form_withがモデルを新規作成と認識するために必要
  def persisted?
    false
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    if order.persisted?
      Address.create(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building: building,
        phone_number: phone_number,
        order_id: order.id
      )
      true
    else
      false
    end
  end
end
