class Blog < ApplicationRecord
  belongs_to :user
  has_many :blog_comments, dependent: :destroy

  validates :title,
  presence: true,
  length: {minimum: 6}

  validates :content,
  presence: true,
  length: {minimum: 40}

end
