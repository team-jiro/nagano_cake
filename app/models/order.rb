class Order < ApplicationRecord

  def subtotal
    item.tax_included_price * amount
  end
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  validates :shipping_address, presence: true
  validates :shipping_postal_code, presence: true
  validates :shipping_name, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2,
                        preparing_delivery: 3, delivered: 4 }

end
