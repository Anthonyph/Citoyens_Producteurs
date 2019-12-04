class Address < ApplicationRecord
  has_one :store
  has_one :user
  has_many :events

  validates :place, presence: true,
  validates :zip_code, presence: true,
  format: { with: /^(?:[0-8]\d|9[0-8])\d{3}$/, message: "veuillez entrer un code postal valide" },
  validates :city, presence: true,
  validates :sector, presence: true,


end
