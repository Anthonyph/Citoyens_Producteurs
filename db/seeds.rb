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
ActiveRecord::Base.connection.reset_pk_sequence!('Comment')
Appointment.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('Appointment')
ProductEvent.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('ProductEvent')
Event.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('Event')
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('User') 
StoreProduct.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('StoreProduct')
Store.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('Store')
Address.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('Address')
EventType.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('EventType')
Product.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('Product')
Unit.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('Unit')

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

event_type_array = ["Récolte","Vente","Cuisine","Préparation de confiture","Kermesse","Ceuillettes", "Ramassage","Tenir la boutique","Inventaire mensuel", "Comptabilité"]

(0..8).each do |i|

  event_type = EventType.new(
    name: event_type_array[i],
  )
  event_type.save

  puts "Event_type seed n° #{i}"
end

