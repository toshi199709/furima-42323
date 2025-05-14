class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  validates :name, :description, :price, presence: true
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: 'を選択してください' }

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'は¥300〜¥9,999,999の範囲で入力してください'
  }, format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }

  validate :image_presence

  private

  def image_presence
    errors.add(:image, 'を添付してください') unless image.attached?
  end
end
