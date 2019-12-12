class UsersController < ApplicationController
  def show
    @events = Event.all
  end

  def update
  
  ###########STRIPE###################
 # Amount in cents
 @amount = 500

 customer = Stripe::Customer.create({
   email: params[:stripeEmail],
   source: params[:stripeToken],
 })

 charge = Stripe::Charge.create({
   customer: customer.id,
   amount: @amount,
   description: 'Rails Stripe customer',
   currency: 'eur',
 })

rescue Stripe::CardError => e
 flash[:error] = e.message
 redirect_to new_charge_path
  ###########STRIPE END###############

  ###########Update in database has_payed#######

  
  ###########UPdate END #####################
  
  ###########MAILER####################

  ###########MAILER END################

  end 
  
end



