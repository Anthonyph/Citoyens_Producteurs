class Product < ApplicationRecord
  has_many :store_products, dependent: :destroy
  has_many :product_appointments, dependent: :destroy
  has_many :product_events, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: true
end
