class Event < ApplicationRecord
  belongs_to :creator, class_name: "User" 
  belongs_to :address
  belongs_to :event_type
  after_create :event_creation_user

  def event_creation_user
    EventMailer.new_event_user(self).deliver_now
  end
  
end
