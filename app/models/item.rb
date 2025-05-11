class Item < ApplicationRecord
  belongs_to :user
  # 必要に応じてバリデーションも追記
end