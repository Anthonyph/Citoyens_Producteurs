class Store < ApplicationRecord
  belongs_to :address
  has_many :store_products
  has_many :products , through: :store_products
  has_many :users
  has_many :events , through: :users


end
