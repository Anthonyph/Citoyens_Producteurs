class Store < ApplicationRecord
  belongs_to :address
  has_many :store_products
  has_many :products , through: :store_products
  has_many :users
  has_many :events, through: :users

  validates :name,
  presence: true,
  length: {maximum: 30}
  


end
