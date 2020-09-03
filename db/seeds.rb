# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Alert.destroy_all
Lead.destroy_all

10.times do
  alert = Alert.new(
    keyword:  Faker::App.name,
    region: Faker::Address.state,
    follower_threshold:  rand(0..1000),
    user_id: User.first.id
  )
  alert.save!
  5.times do 
    lead = Lead.new(
      date: Faker::Date.in_date_period,
      twitter_account: Faker::FunnyName.name,
      handdle: "@#{Faker::FunnyName.name}",
      content: Faker::Quote.famous_last_words,
      retweets_count: rand(0..1000),
      comments_count: rand(0..1000),
      likes_count: rand(0..1000),
      alert_id: alert.id
    )
    lead.save!
  end
end
puts "user 1 finished"

7.times do
  alert = Alert.new(
    keyword:  Faker::App.name,
    region: Faker::Address.state,
    follower_threshold:  rand(0..1000),
    user_id: User.last.id
  )
  alert.save!
  3.times do 
    lead = Lead.new(
      date: Faker::Date.in_date_period,
      twitter_account: Faker::FunnyName.name,
      handdle: "@#{Faker::FunnyName.name}",
      content: Faker::Quote.famous_last_words,
      retweets_count: rand(0..1000),
      comments_count: rand(0..1000),
      likes_count: rand(0..1000),
      alert_id: alert.id
    )
    lead.save!
  end
end
puts "user 2 finished"


