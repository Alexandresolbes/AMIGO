# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

Message.destroy_all
puts "✅ Messages destroyed"

Room.destroy_all
puts "✅ Rooms destroyed"

UserTrip.destroy_all
puts "✅ User Trips destroyed"

Participation.destroy_all
puts "✅ Participations destroyed"

Activity.destroy_all
puts "✅ Activities destroyed"

Trip.destroy_all
puts "✅ Trips destroyed"

User.destroy_all
puts "✅ Users destroyed"

# ALL USERS

file_lounes = URI.open("https://res.cloudinary.com/laura-latuillerie/image/upload/v1661526010/development/nzoznhgn0xydto61hs8c8crlpt1f.jpg")

lounes = User.new(
first_name: "Lounes",
last_name: "Ait",
email: "lounes@test.com",
password: "123456"
)

lounes.photo.attach(io: file_lounes, filename: "lounes.jpg", content_type:"image/jpg")
lounes.save!
p "✅ Lounes created"

file_isabel = URI.open("https://avatars.githubusercontent.com/u/61071369?v=4")

isabel = User.new(
first_name: "Isabel",
last_name: "Lamim",
email: "isabel@test.com",
password: "123456"
)

isabel.photo.attach(io: file_isabel, filename: "isabel.jpg", content_type:"image/jpg")
isabel.save!
p "✅ Isabel created"

file_laura = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1655708276/flpuxxozbaolhgvsimuv.jpg")

laura = User.new(
first_name: "Laura",
last_name: "Latuillerie",
email: "laura@test.com",
password: "123456"
)

laura.photo.attach(io: file_laura, filename: "laura.jpg", content_type:"image/jpg")
laura.save!
p "✅ Laura created"

file_alex = URI.open("https://avatars.githubusercontent.com/u/98179884?v=4")

alexandre = User.new(
first_name: "Alexandre",
last_name: "Solbes",
email: "alexandre@test.com",
password: "123456",
)

alexandre.photo.attach(io: file_alex, filename: "alex.jpg", content_type:"image/jpg")
alexandre.save!
p "✅ Alexandre created"

 #A TRIP

amigo_trip = Trip.new(
destination:"Tokyo",
start_date:"Mon, 29 Aug 2022",
end_date:"Mon, 12 Sep 2022",
user_id: User.first.id,
)

amigo_trip.save!

p "✅ Trip created"

UserTrip.create(
  trip_id: Trip.last.id,
  user_id: User.find_by_first_name('Alexandre').id
)

UserTrip.create(
  trip_id: Trip.last.id,
  user_id: User.find_by_first_name('Lounes').id
)

UserTrip.create(
  trip_id: Trip.last.id,
  user_id: User.find_by_first_name('Isabel').id
)

UserTrip.create(
  trip_id: Trip.last.id,
  user_id: User.find_by_first_name('Laura').id
)

p "✅ User Trips created"

# ACTIVITIES

file_bar = URI.open("https://media.timeout.com/images/103945922/750/422/image.jpg")

bar = Activity.new(
title:"Red bar",
address: "4-5-9 Shibuya, Tokyo",
categories: "Night life",
description: "The Red Bar has a chic atmosphere inspired by the rich European past (crystal chandeliers and red fabrics), but unlike the exclusive clubs of Aoyama, the entrance is open to all and the drinks are surprisingly inexpensive (500 yen glass).",
date: "Tue, 30 Aug 2022",
min_amigos: "2",
trip_id: Trip.first.id
)
bar.photo.attach(io: file_bar, filename: "bar.jpg", content_type:"image/jpg")
bar.save!

file_museum = URI.open("https://www.japan-guide.com/g18/3070_01.jpg")

museum = Activity.new(
title:"Edo Tokyo Museum",
address: "1-4-1 Yokoami, Sumida-Ku, Tokyo",
description: "The Edo-Tokyo Museum (Edo Tōkyō Hakubutsukan) is a historical museum located at 1-4-1 Yokoami, Sumida-Ku, Tokyo in the Ryogoku district. The museum opened in March 1993 to preserve Edo's cultural heritage",
categories: "Cultural",
date: "Wed, 31 Aug 2022",
min_amigos: "4",
trip_id: Trip.first.id
)
museum.photo.attach(io: file_museum, filename: "museum.jpg", content_type:"image/jpg")
museum.save!

file_sumo_tournament = URI.open("https://cdn.cheapoguides.com/wp-content/uploads/sites/2/2012/05/1491460902_c664678033_o-1280x600.jpg")

sumo_tournament = Activity.new(
title:"Sumo tournament",
address: "Ryogoku Kokugikan, Sumida-ku, Tokyo",
description: "Each tournament lasts 15 days during which wrestlers compete in one bout per day except lower ranked wrestlers who compete in fewer bouts. All sumo wrestlers are classified in a ranking hierarchy (banzuke), which is updated after each tournament based on the wrestlers' performance.",
categories: "Sports",
date: "Thu, 01 Sep 2022",
min_amigos: "4",
trip_id: Trip.first.id
)
sumo_tournament.photo.attach(io: file_sumo_tournament, filename: "sumo_tournament.jpg", content_type:"image/jpg")
sumo_tournament.save!

p "✅ Activities created"

Participation.create(
  activity_id: bar.id,
  user_id: User.find_by_first_name('Alexandre').id
)

Participation.create(
  activity_id: bar.id,
  user_id: User.find_by_first_name('Lounes').id
)

Participation.create(
  activity_id: bar.id,
  user_id: User.find_by_first_name('Isabel').id
)

Participation.create(
  activity_id: bar.id,
  user_id: User.find_by_first_name('Laura').id
)
Participation.create(
  activity_id: museum.id,
  user_id: User.find_by_first_name('Alexandre').id
)

Participation.create(
  activity_id: museum.id,
  user_id: User.find_by_first_name('Lounes').id
)

Participation.create(
  activity_id: sumo_tournament.id,
  user_id: User.find_by_first_name('Isabel').id
)

Participation.create(
  activity_id: sumo_tournament.id,
  user_id: User.find_by_first_name('Laura').id
)

p "✅ Participations created"
