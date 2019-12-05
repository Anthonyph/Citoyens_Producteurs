class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :product_appointments, dependent: :destroy
  has_many :products, through: :product_appointments

<<<<<<< HEAD
  # validates :start_date, presence: true, if: :event_past?

  # validates :duration,
  #   presence: true, numericality:  { :greater_than_or_equal_to => 1}, if: :valid_duration?
=======
  validates :start_date, presence: true,
  date: { after: Proc.new { Time.now }}
  
  validates :duration,
  presence: true, numericality:  { :greater_than_or_equal_to => 1}
  
>>>>>>> development

  validates :status, presence: true
  validates :points, presence: true

  #after_create :appointment_creation_user
  #after_create :appointment_creation_creator

  def appointment_creation_user
    AppointmentMailer.new_appointment_user(self).deliver_now
  end

  def appointment_creation_creator
    AppointmentMailer.new_appointment_creator(self).deliver_now
  end

<<<<<<< HEAD
  private
  def event_past?
      self.start_date > DateTime.now
      errors.add(:start_date, "La date de départ de l'event ne peut pas etre dans le passé")
  end

  def valid_duration?
    self.duration % 5 == 0
    self.errors[:base] << "Number must be divisible by 5!"
  end 
=======
>>>>>>> development
 


end
