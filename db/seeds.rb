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
  new_user = User.new(
  email: Faker::Internet.unique.free_email,
  password: "12345678",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
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
  new_coder = Coder.new(
    name: Faker::Name.unique.name,
    price_per_day: ((rand() * 10).round + 1)  * 100,
    email: Faker::Internet.unique.free_email,
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

15.times do
  new_user = user_creation
  new_coder = coder_creation(new_user)

  4.times do
    duration = ((rand() * 10).round * 7) + 1
    valid = (rand() > 0.5)
    date_start = Date.new(2020,6+(rand()*6).round,rand()*28.round+1)
    date_end = date_start + duration
    unless (date_start.nil? || date_end.nil?)
    new_mission = Mission.new(
      start_date: date_start,
      end_date: date_end + duration,
      total_price: ((rand()*9).round + 1 * 100) * duration,
      validated_mission: valid
      )
    new_mission.coder = new_coder
    new_user_for_mission = user_creation
    new_mission.user = new_user_for_mission
    # p new_mission
    new_mission.save
    end
  end

end
