class Event < ApplicationRecord
  belongs_to :creator, class_name: "User" 
  belongs_to :address
  belongs_to :event_type
  has_many :comments
  has_many :appointments 
  has_many :users, through: :appointments  
  has_many :product_events
  has_many :products, through: :product_events
end
