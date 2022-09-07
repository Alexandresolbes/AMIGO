# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

UserNotification.destroy_all
puts "✅ User Notifications destroyed"

UserMessage.destroy_all
puts "✅ User Messages destroyed"

Notification.destroy_all
puts "✅ Notifications destroyed"

Wallet.destroy_all
puts "✅ Wallets destroyed"

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
password: "123456",
admin: true
)

lounes.photo.attach(io: file_lounes, filename: "lounes.jpg", content_type:"image/jpg")
lounes.save!
p "✅ Lounes created"

file_isabel = URI.open("https://avatars.githubusercontent.com/u/61071369?v=4")

isabel = User.new(
first_name: "Isabel",
last_name: "Lamim",
email: "isabel@test.com",
password: "123456",
admin: true
)

isabel.photo.attach(io: file_isabel, filename: "isabel.jpg", content_type:"image/jpg")
isabel.save!
p "✅ Isabel created"

file_laura = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1655708276/flpuxxozbaolhgvsimuv.jpg")

laura = User.new(
first_name: "Laura",
last_name: "Latuillerie",
email: "laura@test.com",
password: "123456",
admin: true
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

file_dante = URI.open("https://avatars.githubusercontent.com/u/11738628?v=4")

dante = User.new(
first_name: "Dante",
last_name: "Planterose",
email: "dante@test.com",
password: "123456"
)

dante.photo.attach(io: file_dante, filename: "dante.jpg", content_type:"image/jpg")
dante.save!
p "✅ Dante created"

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
  user_id: User.find_by_first_name('Laura').id,
  creator: true
)

UserTrip.create(
  trip_id: Trip.last.id,
  user_id: User.find_by_first_name('Dante').id,
  creator: true
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
categories: "Culture",
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

file_kabuki = URI.open("https://tokyo.for91days.com/wp-content/uploads/sites/16/2017/04/Kabuki-Theater-Tokyo-01-20140410-www.for91days.com-DSC03261.jpg")

kabuki = Activity.new(
title:"Kabuki-za",
address: "104-0061 Ginza, Tokyo",
description: "he Kabuki-za was originally opened by a Meiji era journalist, Fukuchi Gen'ichirō. Fukuchi wrote kabuki dramas in which Ichikawa Danjūrō IX and others starred; upon Danjūrō's death in 1903, Fukuchi retired from the management of the theater. The theater is now run by the Shochiku Corporation which took over in 1914.",
categories: "Culture",
date: "Wed, 07 Sep 2022",
min_amigos: "5",
trip_id: Trip.first.id
)

kabuki.photo.attach(io: file_kabuki , filename: "kabuki.jpg", content_type:"image/jpg")
kabuki.save!

file_karaoke = URI.open("https://64.media.tumblr.com/b406a11d5017cf6b5b5392b1cff2fd5c/tumblr_inline_pk070a2Mx61qc7ff0_500.jpg")

karaoke = Activity.new(
title:"Karaokekan",
address: "160-0023 Tokyo, Nishishinjuku, Tokyo ",
description: "Shibuya branch where the karaoke scene in Lost in Translation was filmed. Ask for rooms 601 and 602 if you want to recreate the experience!",
categories: "Night life",
date: "Wed, 07 Sep 2022",
min_amigos: "6",
trip_id: Trip.first.id
)

karaoke.photo.attach(io: file_karaoke, filename: "karaoke.jpg", content_type:"image/jpg")
karaoke.save!

file_cat_cafe = URI.open("https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/2b/de/25/cat-cafe-mocha.jpg?w=1400&h=-1&s=1")

cat_cafe = Activity.new(
title:"Cat cafe Mocha",
address: "Jingumae, Shibuya, Tokyo",
description: "The purring cafe, meet the cats of harajuku",
categories: "Entertainment",
date: "Wed, 07 Sep 2022",
min_amigos: "3",
trip_id: Trip.first.id
)

cat_cafe.photo.attach(io: file_cat_cafe, filename: "", content_type:"image/jpg")
cat_cafe.save!

p "✅ Activities created"

Participation.create(
  activity_id: bar.id,
  user_id: User.find_by_first_name('Alexandre').id,
  creator: true
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
  user_id: User.find_by_first_name('Lounes').id,
  creator: true
)

Participation.create(
  activity_id: sumo_tournament.id,
  user_id: User.find_by_first_name('Isabel').id,
  creator: true
)

Participation.create(
  activity_id: sumo_tournament.id,
  user_id: User.find_by_first_name('Laura').id
)

Participation.create(
  activity_id: kabuki.id,
  user_id: User.find_by_first_name('Alexandre').id,
  creator: true
)

Participation.create(
  activity_id: karaoke.id,
  user_id: User.find_by_first_name('Alexandre').id,
  creator: true
)

Participation.create(
  activity_id: cat_cafe.id,
  user_id: User.find_by_first_name('Alexandre').id,
  creator: true
)

p "✅ Participations created"


Room.create(
  name: "General",
  trip_id: amigo_trip.id
)

Room.create(
  name: "Activities",
  trip_id: amigo_trip.id
)

Room.create(
  name: "Housing",
  trip_id: amigo_trip.id
)

Room.create(
  name: "Bank",
  trip_id: amigo_trip.id
)

p "✅ Rooms created"

UserTrip.all.each { |u| Wallet.create(user_trip_id: u.id) }
