class UsersController < ApplicationController
  def show
    @events = Event.all
    @amount = 2000 #prix de l'adhésion
  end

  def update
  
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
puts "salut"

puts "ca va ?"
  ###########STRIPE END###############

  ###########Update in database has_payed#######
  User.find(params[:id]).update(has_payed: true)
  
  ###########UPdate END #####################
  
  ###########MAILER####################

  ###########MAILER END################
  redirect_to user_path
  rescue Stripe::CardError => e
  flash[:error] = e.message
  end 
  
end



