class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  def taxin_price #合計金額計算で使用
        price*1.1
  end
  
  def get_image
    (image.attached?) ? image: 'no_image.jpg'
  end

end
