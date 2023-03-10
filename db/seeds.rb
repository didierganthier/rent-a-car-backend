# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#      RUN RAILS DB:SEED TO CREATE THESE DATA IN THE DATABASE
@user1 = User.create(name: 'John Jones', email: 'johnjones@gmail.com', password: '12345678', password_confirmation: '12345678')
@car1 = Car.create(name: 'Tesla Model S', car_type: 'rangerover', description: 'the fastest car in the market', image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla/8a74d206-66dc-4386-8c7a-88ff32174e7d/bvlatuR/std/4096x2560/Model-S-Main-Hero-Desktop-LHD', brand: 'Tesla', daily_rate: 2324)
@car2 = Car.create(name: 'Tesla Model Y', car_type: 'landcruiser', description: 'the fastest car on land in the market', image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla/91abd4c7-32a1-41cc-ade5-b64774dbea61/bvlatuR/std/2880x1800/Model-Y-Main-Hero-Desktop-Global?quality=auto-medium&amp;format=auto', brand: 'Tesla', daily_rate: 3000)
@car3 = Car.create(name: 'Tesla Model X', car_type: 'speedstar', description: 'the fastest car ever made', image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla/8c26f779-11e5-4cfc-bd7c-dcd03b18ff88/bvlatuR/std/4096x2561/Model-X-Main-Hero-Desktop-LHD', brand: 'Tesla', daily_rate: 1234)
@car4 = Car.create(name: 'Tesla Model Z', car_type: 'sportscar', description: 'the fastest sportscar in the market', image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla/8a74d206-66dc-4386-8c7a-88ff32174e7d/bvlatuR/std/4096x2560/Model-S-Main-Hero-Desktop-LHD', brand: 'Tesla', daily_rate: 3224)
Reservation.create(reservation_date: '01-05-2023', due_date: '05-05-2023', user_id: @user1, car_id: @car1)