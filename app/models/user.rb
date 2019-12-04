class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 belongs_to :address
 belongs_to :store
 after_create :welcome_send

  def welcome_send
  UserMailer.welcome_email(self).deliver_now
  end


end
