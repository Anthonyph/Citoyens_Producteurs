class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :text, 
    presence: true,
    length: {maximum: 250}



  

  
  #after_create :mail_to_event_creator

  def mail_to_event_creator
    CommentMailer.new_comment(self).deliver_now
  end

end
