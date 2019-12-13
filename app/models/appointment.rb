class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :product_appointments, dependent: :destroy
  has_many :products, through: :product_appointments
  include Feedbackable

  
  # date: { after: Proc.new { Time.now }}
  # validates :start_date, presence: true,
  

  

  validates :status, presence: true
  
  

  after_create :appointment_creation_user
  after_create :appointment_creation_creator


  def appointment_creation_user
    AppointmentMailer.new_appointment_user(self).deliver_now
  end

  def appointment_creation_creator
    AppointmentMailer.new_appointment_creator(self).deliver_now
  end

  def appointment_destroy_user
    AppointmentMailer.destroy_appointment_user(self).deliver_now
  end

  def appointment_destroy_creator
    AppointmentMailer.destroy_appointment_creator(self).deliver_now
  end
 

end
