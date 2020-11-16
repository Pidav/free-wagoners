# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'date'

5.times do
  puts "creating user"
  new_user = User.new(
    email: Faker::Internet.unique.free_email,
    password: "12345678",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    company_name: Faker::Company.name,
    description: Faker::Lorem.sentence(word_count: 15),
    phone_number: "+33 #{Faker::PhoneNumber.subscriber_number(length: 9)}"
    )
  new_user.save
  puts new_user
  new_coder = Coder.new(
    name: Faker::Name.unique.name,
    price_per_day: (rand()*10).round * 100,
    email: Faker::Internet.unique.free_email,
    description: Faker::Lorem.sentence(word_count: 25),
    phone_number: "+33 #{Faker::PhoneNumber.subscriber_number(length: 9)}",
    )
  new_coder.user = new_user
  new_coder.save
  puts "coder created"
  puts new_coder
  4.times do
    p new_coder
    duration = ((rand() * 10).round * 7)
    valid = (rand() > 0.5)
    new_mission = Mission.new(
      start_date: Date.today,
      end_date: Date.today + duration,
      total_price: (rand()*10).round * 100,
      validated_mission: valid
      )
    new_mission.coder = new_coder
    puts new_mission.coder
    new_user_for_mission = User.new(
      email: Faker::Internet.unique.free_email,
      password: "12345678",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      company_name: Faker::Company.name,
      description: Faker::Lorem.sentence(word_count: 15),
      phone_number: "+33 #{Faker::PhoneNumber.subscriber_number(length: 9)}"
      )
    new_user_for_mission.save
    new_mission.user = new_user_for_mission
    puts new_mission
    p new_mission
    new_mission.save
  end

end
