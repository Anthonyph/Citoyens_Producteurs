class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  after_create :appointment_creation_user
  after_create :appointment_creation_creator

    def appointment_creation_user
      AppointmentMailer.new_appointment_user(self).deliver_now
    end

    def appointment_creation_creator
      AppointmentMailer.new_appointment_creator(self).deliver_now
    end
    
end
