class Unit < ApplicationRecord
  has_many :product_appointments
  has_many :product_events
  has_many :store_products

  validates :name,
  presence: true,
  length: {maximum: 10}


  
end
