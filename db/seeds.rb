# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
  10.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create!(first_name: first_name, last_name: last_name, email: Faker::Internet.free_email("#{first_name}_#{last_name}"),
                 password: '123123', password_confirmation: '123123')
  end
  User.create(first_name: 'tan', last_name: 'bui', email: 'tan@gmail.com', password: '123123', password_confirmation: '123123')
end
