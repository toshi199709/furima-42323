class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  validates :name, :description, :price, :image, presence: true
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_day_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_day_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は¥300〜¥9,999,999の範囲で入力してください' },
                    format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }
end
