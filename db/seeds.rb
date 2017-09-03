# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0

  two_member_team = []
  5.times do
    two_member_team << Team.create!(name: Faker::Team.name)
  end

  one_member_team = []
  5.times do
    one_member_team << Team.create!(name: Faker::Team.name)
  end


  10.times do |i|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    user = User.create!(first_name: first_name, last_name: last_name, email: Faker::Internet.free_email("#{first_name}_#{last_name}"),
                 password: '123123', password_confirmation: '123123')
    user.team_members.create!(team: two_member_team[i/2])
  end

  10.times do |i|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    user = User.create!(first_name: first_name, last_name: last_name, email: Faker::Internet.free_email("#{first_name}_#{last_name}"),
                 password: '123123', password_confirmation: '123123')
    if i < 5
      user.team_members.create!(team: one_member_team[i])
    end
  end

  User.create(first_name: 'tan', last_name: 'bui', email: 'tan@gmail.com', password: '123123', password_confirmation: '123123')

  team_ids = Team.all.map(&:id)

  10.times do |i|
    match = Match.create(home_team_id: team_ids[i], away_team_id: (team_ids - [team_ids[i]]).sample )

    3.times do
      if match.status != 'finished'
        home_point = (0..10).to_a.sample
        away_point = ((0..10).to_a - [home_point]).sample
        match.games.create!(home_point: home_point, away_point: away_point)
      end
    end
  end
end
