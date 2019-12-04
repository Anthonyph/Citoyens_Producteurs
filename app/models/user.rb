class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 belongs_to :address
 belongs_to :store     
 has_many :comments, dependent: :destroy
 
 has_many :created_events, foreign_key: 'creator_id', class_name: 'Event', dependent: :destroy
 has_many :appointments, dependent: :destroy
 has_many :events, through: :appointments

 

end
