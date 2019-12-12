class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  belongs_to :address, optional: true
  belongs_to :store, optional: true
  has_many :comments, dependent: :destroy
  
  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event', dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :events, through: :appointments
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email address please" }
  before_create :set_default_store
  after_create :welcome_send
  after_create :create_address
  after_update :membership_fee_payed

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def create_address
    @user = self
    @address = Address.create(place: "default", zip_code: "11111", city: "default", sector: "default")
    @user.update(address_id: @address.id)
  end

  def set_default_store
    
    self.store_id = 1
  end

  def membership_fee_payed
    UserMailer.user_has_payed(self).deliver_now
  end




end
