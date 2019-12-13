class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @events = Event.all
    @amount = 2000 #prix de l'adhésion
  end

  def update
  member = User.find(params[:id])
  ###########STRIPE###################
 # Amount in cents
 @amount = 2000
 customer = Stripe::Customer.create({
   email: params[:stripeEmail],
   source: params[:stripeToken],
 })

 charge = Stripe::Charge.create({
   customer: customer.id,
   amount: @amount.to_i ,
   description: 'Rails Stripe customer',
   currency: 'eur',
 })

  ###########STRIPE END###############

  ###########Update in database has_payed#######
  member.update(has_payed: true)
  
  ###########UPdate END #####################

  UserMailer.user_has_payed(member).deliver_now

  redirect_to user_path
  rescue Stripe::CardError => e
  flash[:error] = e.message
  end 
  
end



