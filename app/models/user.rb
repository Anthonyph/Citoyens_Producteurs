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
 validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }

 after_create :welcome_send

  def welcome_send
  UserMailer.welcome_email(self).deliver_now
  end



end
