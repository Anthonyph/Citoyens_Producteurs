class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 belongs_to :address
 belongs_to :store
 after_create :usermail

  def usermail
  UserMailer.welcome_email(self).deliver_now
  end


end
