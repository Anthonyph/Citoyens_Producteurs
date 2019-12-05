class Address < ApplicationRecord
  has_one :store
  has_one :user
  has_many :events

  validates :place, presence: true
  validates :zip_code, presence: true, zipcode: { country_code: :fr }
  validates :city, presence: true
  validates :sector, presence: true


end
