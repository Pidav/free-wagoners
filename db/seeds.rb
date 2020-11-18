# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'date'

def user_creation
  user_first_name = Faker::Name.first_name
  user_last_name = Faker::Name.unique.last_name
  new_user = User.new(
  email: "#{user_first_name}.#{user_last_name}@#{Faker::Internet.domain_name}",
  password: "12345678",
  first_name: user_first_name,
  last_name: user_last_name,
  company_name: Faker::Company.name,
  description: Faker::Lorem.sentence(word_count: 15 + rand() * 20),
  phone_number: "+33 #{[1,6,7].sample}#{Faker::PhoneNumber.subscriber_number(length: 8)}"
  )
  if !new_user.save
    puts "erreur user"
    p new_user
  end
  return new_user
end

def coder_creation(user)
  coder_name = Faker::Name.unique.name
  new_coder = Coder.new(
    name: coder_name,
    price_per_day: ((rand() * 10).round + 1)  * 100,
    email: Faker::Internet.unique.free_email(name: coder_name),
    description: Faker::Lorem.sentence(word_count: 25 + rand() * 20 ),
    phone_number: "+33 #{[1,6,7].sample}#{Faker::PhoneNumber.subscriber_number(length: 8)}",
    )
  new_coder.user = user
  if !new_coder.save
    puts "erreur coder"
    p new_coder
  end
  return new_coder
end

def mission_creation(coder)
  duration = ((rand() * 10).round * 7) + 1
  valid = (rand() > 0.25)
  date_start = Date.new(2020,6+(rand()*6).round,rand()*28.round+1)
  date_end = date_start + duration
  unless (date_start.nil? || date_end.nil?)
    new_mission = Mission.new(
      start_date: date_start,
      end_date: date_end + duration,
      total_price: ((rand()*9).round + 1 * 100) * duration,
      validated_mission: valid,
      title: Faker::Company.bs,
      description: Faker::Lorem.sentence(word_count: 5 + rand() * 10 )
      )
    new_mission.coder = coder
    new_mission.user = user_creation
  end
  if !new_mission.save
    puts "erreur mission"
    p new_mission
  else
    return new_mission
  end
end

15.times do
  new_user = user_creation
  new_coder = coder_creation(new_user)
  4.times do
    mission_creation(new_coder)
  end
end
