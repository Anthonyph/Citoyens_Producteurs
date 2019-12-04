class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 belongs_to :address
 belongs_to :store     
 has_many :comments
 has_many :events
 has_many :appointments



end
