class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :product_appointments
end
