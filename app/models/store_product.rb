class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store
  belongs_to :unit
end
