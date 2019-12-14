class EventType < ApplicationRecord
  has_many :events, dependent: :nullify
end
