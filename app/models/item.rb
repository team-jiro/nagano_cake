class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  def tax_included_price
    (price*1.1).floor
  end

  def get_image
    (image.attached?) ? image: 'no_image.png'
  end

end
