class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :text, presence: true,
  length: {maximum: 250}



  

  

end
