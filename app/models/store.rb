class Store < ApplicationRecord
  belongs_to :address
  has_many :store_products, dependent: :destroy
  has_many :products , through: :store_products
  has_many :users, dependent: :nullify
  has_many :events, through: :users, dependent: :nullify

  validates :name,
  presence: true,
  length: {maximum: 30}
  


end
