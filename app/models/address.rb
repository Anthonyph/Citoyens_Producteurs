class Address < ApplicationRecord
  has_one :store
  has_one :user
  has_many :events
  

end
