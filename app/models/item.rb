class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  validates :image, presence: { message: 'must be attached' }
  validates :name, :description, presence: true

  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: 'must be selected' }

  validate :price_validation

  private

  def price_validation
    raw_price = attributes_before_type_cast['price']
    puts "DEBUG: raw_price = #{raw_price.inspect}"

    if raw_price.blank?
      errors.add(:price, "can't be blank")
      return
    end

    unless raw_price.to_s.match?(/\A[0-9]+\z/)
      errors.add(:price, 'must be a half-width number')
      return
    end

    int_price = raw_price.to_i
    return if int_price.between?(300, 9_999_999)

    errors.add(:price, 'must be between ¥300 and ¥9,999,999')
  end
end
