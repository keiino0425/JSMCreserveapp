class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reservations, dependent: :destroy
  has_many :temp_reservations, dependent: :destroy

  validates :email, :user_name, :curriculum, :user_address, presence: true
  validates :email, uniqueness: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲストユーザー"
      user.curriculum = "ドライヘッドスパ"
      user.user_address = "大阪府大阪市中央区大阪城１−１"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
