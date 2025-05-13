class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :last_name_kana, presence: true, format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }

  validates :birthday, presence: true

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字を含めてください' }, unless: lambda {
    password.blank?
  }
end
