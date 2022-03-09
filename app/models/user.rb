class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 正規表現
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_NAME_REGEX = /\A[ァ-ヴー]+\z/u
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  # エラーメッセージ
  FULL_WIDTH_ERROR = 'is invalid. Input full-width characters'
  FULL_WIDTH_KANA_ERROR = 'is invalid. Input full-width katakana characters'
  PASSWORD_ERROR = 'is invalid. Include both letters and numbers'

  # バリデーション
  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_NAME_REGEX, message: FULL_WIDTH_ERROR }
    validates :first_name, format: { with: VALID_NAME_REGEX, message: FULL_WIDTH_ERROR }
    validates :kana_last_name, format: { with: VALID_KANA_NAME_REGEX, message: FULL_WIDTH_KANA_ERROR }
    validates :kana_first_name, format: { with: VALID_KANA_NAME_REGEX, message: FULL_WIDTH_KANA_ERROR }
    validates :birthday
  end
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: PASSWORD_ERROR }

  #アソシエーション
  has_many :items
end
