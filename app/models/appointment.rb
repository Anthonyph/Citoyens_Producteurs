class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :product_appointments, dependent: :destroy
  has_many :products, through: :product_appointments

  validates :start_date,
  presence: true,
  validate :event_past
  validates :duration,
  presence: true,:numericality => { :greater_than_or_equal_to => 1}
  validate :valid_duration
  validates :status, presence: true,
  validates :points, presence: true

  private
  def event_past
   
    if start_date < DateTime.now
      errors.add(:start_date, "La date de départ de l'event ne peut pas etre dans le passé")
    end
  end

  def valid_duration
    if (self.duration % 5) != 0
      self.errors[:base] << "Number must be divisible by 5!"
    end
      
  end

  

  

  
 

end
