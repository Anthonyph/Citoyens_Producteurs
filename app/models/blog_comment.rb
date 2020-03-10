class BlogComment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :text, 
    presence: true,
    length: {maximum: 250}
end
