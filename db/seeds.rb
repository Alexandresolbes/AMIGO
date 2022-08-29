# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

User.destroy_all
puts " Users destroyed"

# ALL USERS

file_lounes = URI.open("https://resize.programme-television.ladmedia.fr/r/650,406/img/var/premiere/storage/images/tele-7[…]-de-malcolm-4629756/hal/94988895-1-fre-FR/Hal.jpg")

lounes = User.new(
first_name: "Lounes",
last_name: "Ait",
email: "lounes@test.com",
password: "123456"
)

lounes.photo.attach(io: file_lounes, filename: "lounes.jpg", content-type:"image/jpg")
lounes.save!
p "Lounes created"

file_isabel = URI.open("https://avatars.githubusercontent.com/u/61071369?v=4")

isabel = User.new(
first_name: "Isabel",
last_name: "Lamim",
email: "isabel@test.com",
password: "123456"
)

isabel.photo.attach(io: file_isabel, filename: "isabel.jpg", content-type:"image/jpg")
isabel.save!
p "Isabel created"

file_laura = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1655708276/flpuxxozbaolhgvsimuv.jpg")

laura = User.new(
first_name: "Laura",
last_name: "Latuillerie",
email: "laura@test.com",
password: "123456"
)

laura.photo.attach(io: file_laura, filename: "laura.jpg", content-type:"image/jpg")
laura.save!
p "Laura created"

file_alex = URI.open("https://avatars.githubusercontent.com/u/98179884?v=4")

alexandre = User.new(
first_name: "Alexandre",
last_name: "Solbes",
email: "alexandre@test.com",
password: "123456",
)

alexandre.photo.attach(io: file_alex, filename: "alex.jpg", content-type:"image/jpg")
alex.save!
p "Alexandre created"

# A TRIP

trip_creator = User.where(first_name: "Alexandre").id

file_amigo_trip = URI.open("https://www.google.com/search?q=shibuya+crossing&sxsrf=ALiCzsZsmiIXBXCxgz56CFnTdzC-Ej_PUQ:1661769610587&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjjodma7uv5AhWJwYUKHS6pD6AQ_AUoAXoECAIQAw&biw=1440&bih=813&dpr=1.5#imgrc=n2X_Y_P9CNiaIM")

amigo_trip = Trip.new(
destination:"Tokyo",
start_date:"Mon, 29 Aug 2022",
end_date:"Mon, 12 Sep 2022",
user_id: trip_creator,
)
amigo_trip.photo.attach(io: file_amigo_trip, filename: "amigo_trip.jpg", content-type:"image/jpg")
amigo_trip.save!

p "Trip created"
