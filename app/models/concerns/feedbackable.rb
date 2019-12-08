module Feedbackable
  extend ActiveSupport::Concern

  included do
    has_many :feedbacks, as: :feedbackable
  end
end