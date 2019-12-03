class Event < ApplicationRecord
  belongs_to :creator, class_name: "User" 
  belongs_to :address
  belongs_to :event_type
end
