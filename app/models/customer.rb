class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :ships, dependent: :destroy

  # カラムの保存許可設定
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, uniqueness: true


  # 会員フルネーム
  def full_name
    self.last_name + " " + self.first_name
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
