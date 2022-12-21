class Ship < ApplicationRecord
  belongs_to :customer
  validates :address, presence: true
  validates :post_code, presence: true
  validates :name, presence: true
end
