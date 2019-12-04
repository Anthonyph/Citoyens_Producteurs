class Product < ApplicationRecord
  has_many :store_products
  has_many :product_appointments
  has_many :product_events
end
