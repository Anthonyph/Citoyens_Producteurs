# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


################# DATABASE DESTROY ##########################

ProductAppointment.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('ProductAppointment')
Comment.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('comments')
Appointment.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('appointments')
ProductEvent.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('product_events')
Event.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('events')
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users') 
StoreProduct.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('store_products')
Store.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('stores')
Address.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('addresses')
EventType.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('event_types')
Product.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('products')
Unit.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('units')

################# DATABASE DESTROY ##########################
require 'faker'
require 'time'

t1 = Time.parse("2019-12-13 00:40:00")
t2 = Time.parse("2020-02-01 00:00:00")

########### Unit ###########
array_unit = ["kg", "L", "unité","pot"]
arrayunitlength = array_unit.length

(0..arrayunitlength).each do |i|
  unit = Unit.new(
  name: array_unit[i]
  )
  unit.save
  puts "unit n°#{i} done"
end

########### PRODUCT #################

(0..10).each do |i|
  product = Product.new(
  name:Faker::Food.fruits,
  )
  product.save
  
  product = Product.new(
    name:Faker::Food.vegetables,
    )
  product.save

  product = Product.new(
    name:Faker::Food.ingredient,
    )
  product.save
end

puts "Product seed done, load 30 products"

########### ADDRESS #################

(0..20).each do |i|

  address = Address.new(
    place:Faker::Address.street_name,
    zip_code: "92340",
    city: "Bourg-la-Reine",
    sector: ["Bobo","Riche","Pauvre","Hopitaux","Centre"].sample, 
  )
  address.save
  puts "Address seed n° #{i}"
end

########### EVENT_TYPE #################

event_type_array = ["Harvest","Sell","Cooking","Fruit jam preparation","Kermesse","crop", "picking","Store","Inventory", "Accounting"]

(0..8).each do |i|

  event_type = EventType.new(
    name: event_type_array[i],
  )
  event_type.save

  puts "Event_type seed n° #{i}"
end

########### STORE #################

(0..11).each do |i|
  store = Store.new(
    name: Faker::Company.name,
    address_id:rand(0..20),
  )
  store.save
  puts "Store seed n° #{i}"
end

########### USER #################

user = User.new(
  first_name: "Anthony", 
  last_name: "Phim", 
  email: "anthony.phim@gmail.com", 
  password: "azerty34",
  address_id:rand(1..20),
  store_id: "2",
  phone_number:Faker::PhoneNumber.phone_number,
)
user.save
puts "Anthony done"
user = User.new(
  first_name: "Leo", 
  last_name: "Vanel", 
  email: "leovanel@hotmail.com", 
  password: "azerty34",
  address_id:rand(1..20),
  store_id:"2",
  phone_number:Faker::PhoneNumber.phone_number,
)
user.save
puts "Leo done"
user = User.new(
  first_name: "Augustin", 
  last_name: "De Louvencourt", 
  email: "mail23@yopmail.com", 
  password: "azerty34",
  address_id:rand(1..20),
  store_id:"2",
  phone_number:Faker::PhoneNumber.phone_number,
)
user.save
puts "Augustin done"
user = User.new(
  first_name: "Thibault", 
  last_name: "Mariolle", 
  email: "Thib@yopmail.com", 
  password: "azerty34",
  address_id:rand(1..20),
  store_id:"2",
  phone_number:Faker::PhoneNumber.phone_number,
)
user.save
puts "Thib done"
user = User.new(
  first_name: "Lana", 
  last_name: "Vizoli", 
  email: "Lana@yopmail.com", 
  password: "azerty34",
  address_id:rand(1..20),
  store_id:"2",
  phone_number:Faker::PhoneNumber.phone_number,
)
user.save
puts "Lana done" 
(0..15).each do |i|
  username = Faker::GreekPhilosophers.name
  lastnameuser = Faker::Creature::Cat.name

  user = User.new(
    first_name: username, 
    last_name: lastnameuser, 
    email:"#{username}.#{lastnameuser}@yopmail.com", 
    password:"azerty34",
    address_id:rand(1..20),
    store_id: rand(1..10),
    phone_number:Faker::PhoneNumber.phone_number,
  )

  user.save
  puts "user seed n°#{i}" 
end
puts "user DONE" 

########### STORE_PRODUCT 3rd #################

(0..25).each do |i|
  storeproduct = StoreProduct.new(
    product_id:rand(0..30),
    store_id:rand(0..10),
    quantity:rand(2..99),
    unit_id: rand(0..arrayunitlength),
  )
  storeproduct.save
  puts "store_product seed n° #{i}"
end 
########### EVENT 4th #################


(0..25).each do |i|
  startdate = rand(t1..t2)

  event = Event.new(
  title: Faker::Restaurant.name,
  description: Faker::Restaurant.description,
  start_date: startdate, 
  end_date: startdate + rand(900..7600),
  address_id: rand(0..20), 
  creator_id: rand(1..20), 
  event_type_id:rand(0..8),
  )
  event.save

  puts "event seed n° #{i}"
end

########### COMMENT #################

(0..25).each do |i|
  comment = Comment.new(
    text:Faker::Lorem.characters(number: 200),
    user_id:rand(0..20),
    event_id:rand(0..25),
  )
  comment.save
  puts "comment seed n° #{i}"
end

########### APPOINTMENT #################
  
  timenow = Time.now
  (0..25).each do |i|
      startdate = rand(timenow..t2)
      
    appointment = Appointment.new(
    user_id:rand(0..20),
    event_id:rand(0..25),
    start_date: startdate,
    duration:rand(30..300)*5,
    status: "Future appointment",
    points:rand(5..100))
    appointment.save

  puts "Appointment seed n°#{i} done"
  end

########### PRODUCT_EVENT #################

(0..25).each do |i|
  productevent = ProductEvent.new(
    product_id:rand(1..30),
    event_id:rand(0..25) ,
    unit_id: rand(0..arrayunitlength),  
    quantity: rand(1.99),
  )
  productevent.save
  
puts "Product Event seed n°#{i} done"
end


########### PRODUCT_APPOINTMENT #################

(0..20).each do |i|
  productappointment = ProductAppointment.new(
    product_id: rand(1..30),
    appointment_id:rand(0..25),
    quantity: rand(1..99),
    unit_id: rand(0..arrayunitlength),
  )
  productappointment.save
  puts "Product_appointment seed n°#{i} done"
end
