class ProductEvent < ApplicationRecord
  belongs_to :product
  belongs_to :event
  belongs_to :unit
end
