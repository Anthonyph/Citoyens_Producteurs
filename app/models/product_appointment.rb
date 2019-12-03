class ProductAppointment < ApplicationRecord
  belongs_to :product
  belongs_to :appointment
  belongs_to :unit
end
