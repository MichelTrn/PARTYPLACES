# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Faker::Config.locale = 'fr'


puts 'Cleaning database...'
Booking.destroy_all
Place.destroy_all
User.destroy_all

# Seed pour Nathaly

puts 'Creating 1 user(Nathaly)'

user1 = User.create!(
  first_name: "Nathaly",
  last_name: "Gomez",
  birth_date: "1995-06-23",
  email: "nath@gmail.com",
  password: "123456"
)

user2 = User.create!(
  first_name: "Pierre",
  last_name: "La Rente",
  birth_date: "1950-06-23",
  email: "Pierre-la-rente@gmail.com",
  password: "123456"
)

puts 'Creating 3 places and 6 bookings per place for Nathaly via unplash'
puts 'First creation'

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
place1 = user1.places.new(name: Faker::Restaurant.name, address: "3 Boulevard de Grenelle, Paris", price: rand(400..1000))
# Attach the photo using your Cloudinary config
place1.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place1.save!

puts 'Creating 6 bookings for places Nathaly via unplash'
6.times do
  booking = Booking.new(
    status: ["pending confirmation", "booked", "refused"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
  )
  booking.user = user1
  booking.place = place1
  booking.save!
end

puts '2nd creation'

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
place1 = user1.places.new(name: Faker::Restaurant.name, address: " 4 Impasse Morlet, Paris", price: rand(400..1000))
# Attach the photo using your Cloudinary config
place1.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place1.save!

puts 'Creating 6 bookings for places Nathaly via unplash'
6.times do
  booking = Booking.new(
    status: ["pending confirmation", "booked", "refused"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
  )
  booking.user = user1
  booking.place = place1
  booking.save!
end


puts '3rd creation'

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
place1 = user1.places.new(name: Faker::Restaurant.name, address: " 13 rue Pierre Fontaine, Paris", price: rand(400..1000))
# Attach the photo using your Cloudinary config
place1.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place1.save!

6.times do
  booking = Booking.new(
    status: ["pending confirmation", "booked", "refused"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
  )
  booking.user = user1
  booking.place = place1
  booking.save!
end


# Seed pour les fakes users
puts 'Creating 7 fake users and fake places via unsplash'

puts 'Creating 1st fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "57 rue Sadi Carnot, Aubervilliers ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!

puts 'Creating 2nd fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "28 avenue du Marechal Juin, Saint-louis ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!


puts 'Creating 3rd fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "16 Rue Duvivier, Paris ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!

puts 'Creating 4th fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "8 rue Lacretelle, Paris ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!


puts 'Creating 5th fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "3 rue de l'Arsenal, Paris ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!


puts 'Creating 6th fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "34 rue des Maronites, Paris ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!

puts 'Creating 7th fake user and fake place via unsplash'
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

place2 = user.places.new(name: Faker::Restaurant.name, address: "22 avenue de la Porte de Vitry, Paris ", price: rand(400..1000))
place2.photo.attach(io: file, filename: "bar.png", content_type: "image/png")
place2.save!



puts 'Creating 3 bookings'

3.times do
  booking = Booking.new(
    status: ["pending confirmation", "booked", "refused"].sample,
    begin_date: Faker::Date.between(from: '2022-09-23', to: '2023-01-13'),
    end_date: Faker::Date.between(from: '2023-01-14', to: Date.today)
      )
  booking.user = User.where.not(id: user1).sample
  booking.place = place2
  booking.save!
end


puts 'Seed finished'
