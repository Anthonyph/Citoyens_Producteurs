class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  after_create :mail_to_event_creator

  def mail_to_event_creator
    CommentMailer.new_comment(self).deliver_now
  end

end
