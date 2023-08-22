# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"


puts 'Cleaning database...'
Booking.destroy_all
Place.destroy_all
User.destroy_all

puts 'Creating 1 user, 2 user places'

user1 = User.create!(
  first_name: "Nathaly",
  last_name: "Gomez",
  birth_date: "1995-06-23",
  email: "nath@gmail.com",
  password: "123456"
)

place1 = user1.places.create!(
  name: Faker::Restaurant.name,
  address: Faker::Address.full_address,
  price: Faker::Number.within(range: 400..1000),
  picture_url: "https://source.unsplash.com/random"
)

place2 = user1.places.create!(
  name: Faker::Restaurant.name,
  address: Faker::Address.full_address,
  price: Faker::Number.within(range: 400..1000),
  picture_url: "https://images.unsplash.com/photo-1662519951792-029952e7556b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHBob3RvJTIwYmFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60"
)

puts 'Creating 10 fake users and fake places'

10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birth_date: Faker::Date.birthday,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save!
  user.places.create!(
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    price: Faker::Number.within(range: 400..1000),
    picture_url: "https://source.unsplash.com/random"
  )
end

puts 'Creating 4 bookings '

3.times do
  booking = Booking.new(
    status: ["booked", "available", "refused", "pending confirmation"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
  )
  booking.user = User.where.not(id: user1).sample
  booking.place = place1
  booking.save!
end

booking = Booking.new(
  status: ["booked", "available", "refused", "pending confirmation"].sample,
  begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
  end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
)
booking.user = User.where.not(id: user1).sample
booking.place = place2
booking.save!

puts 'Finished!'
