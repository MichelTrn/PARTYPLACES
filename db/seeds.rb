# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts 'Cleaning database...'
Booking.destroy_all
Place.destroy_all
User.destroy_all

puts 'Creating 1 user and user places'

user1 = User.create!(
  first_name: "Nathaly",
  last_name: "Gomez",
  birth_date: "1995-06-23",
  email: "nath@gmail.com",
  password: "123456"
)

# place1 = user1.places.create!(
#   name: Faker::Restaurant.name,
#   address: Faker::Address.full_address,
#   price: Faker::Number.within(range: 400..1000),
#   picture_url: "https://source.unsplash.com/random"
# )

url = "https://api.unsplash.com/photos/random?client_id=#{ENV["ACCESS_KEY"]}&query=bar"
photo_serialized = URI.open(url).read
photo_json = JSON.parse(photo_serialized)
photo_url = photo_json["urls"]["small"]
file = URI.open(photo_url)
place1 = user1.places.new(name: Faker::Restaurant.name, address: Faker::Address.full_address, price: rand(400..1000))
# Attach the photo using your Cloudinary config
place1.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place1.save!


puts 'Creating 1 seed via unplash'

# Build the URL for your query to unsplash
# with your access_key and a query for some keywords:
url = "https://api.unsplash.com/photos/random?client_id=#{ENV["ACCESS_KEY"]}&query=bar"

# Fetch this URL, it will return a json containing infos about 1 random photo
photo_serialized = URI.open(url).read
photo_json = JSON.parse(photo_serialized)
# Get the URL for one of the sizes (small is the smallest obvy)
photo_url = photo_json["urls"]["small"]

# Download this photo and save it into a variable
file = URI.open(photo_url)
place2 = user1.places.new(name: Faker::Restaurant.name, address: Faker::Address.full_address, price: rand(400..1000))
# Attach the photo using your Cloudinary config
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!

puts 'Creating 10 fake users and fake places via unsplash'

10.times do
  url = "https://api.unsplash.com/photos/random?client_id=#{ENV["ACCESS_KEY"]}&query=bar"
  photo_serialized = URI.open(url).read
  photo_json = JSON.parse(photo_serialized)
  photo_url = photo_json["urls"]["small"]
  file = URI.open(photo_url)

  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birth_date: Faker::Date.birthday,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save!

  place = user.places.new(name: Faker::Restaurant.name, address: Faker::Address.full_address, price: rand(400..1000))
  place.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
  place.save!
end

# 10.times do
#   user = User.new(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     birth_date: Faker::Date.birthday,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password
#   )
#   user.save!
#   user.places.create!(
#     name: Faker::Restaurant.name,
#     address: Faker::Address.full_address,
#     price: Faker::Number.within(range: 400..1000),
#     picture_url: "https://source.unsplash.com/random"
#   )
# end

puts 'Creating 3 bookings '

3.times do
  booking = Booking.new(
    status: ["pending confirmation"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
  )
  booking.user = User.where.not(id: user1).sample
  booking.place = place1
  booking.save!
end

2.times do
  booking = Booking.new(
    status: ["booked","pending confirmation"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
  )
  booking.user = User.where.not(id: user1).sample
  booking.place = place2
  booking.save!
end

10.times do
booking = Booking.new(
  status: ["pending confirmation", "booked", "refused"].sample,
  begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
  end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
)
booking.user = user1
booking.place = place1
booking.save!
end

puts 'Seed finished'
