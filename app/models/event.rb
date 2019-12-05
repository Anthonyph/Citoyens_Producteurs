class Event < ApplicationRecord
  belongs_to :creator, class_name: "User" 
  belongs_to :address
  belongs_to :event_type
  has_many :comments, dependent: :destroy
  has_many :appointments, dependent: :destroy 
  has_many :users, through: :appointments  
  has_many :product_events, dependent: :destroy
  has_many :products, through: :product_events


  validates :title,
  presence: true,
  length: {maximum: 30}

  validates :description,
  presence: true,
  length: {maximum: 250}
  

  validates :start_date, presence: true,  if: :event_past?

  validates :end_date, presence: true, if: :after_start_date?

  def event_creation_user
    EventMailer.new_event_user(self).deliver_now
  end
  
  private

  def event_past?
   
    start_date > DateTime.now
    errors.add(:start_date, "La date de départ de l'event ne peut pas etre dans le passé")
  end

  def after_start_date?

    end_date < start_date
    errors.add(:end_date, "La date de fin de l'évent doit être aprés le début de l'évent")

  end

end

