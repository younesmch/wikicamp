require 'faker'
require 'rolify'
require 'factory_girl_rails'

#create users do you need to add a role to the user?
 5.times do
   User.create!(email: Faker::Internet.email, password: Faker::Internet.password )
 end

users = User.all

#create wikis - do you need to add a user to it as well?
15.times do
  user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password )
  Wiki.create!(user: user,
    title: Faker::LordOfTheRings.location,
    body: Faker::HitchhikersGuideToTheGalaxy.quote
  )
end

wikis = Wiki.all

freemember = User.create!(email: 'member@example.com', password: 'helloworld', confirmed_at: '2016-08-14')

premium = User.create!(email: 'premium@example.com', password: 'helloworld', confirmed_at: '2016-08-14')
premium.remove_role :free
premium.add_role :premium

admin = User.create!(email: 'admin@example.com', password: 'helloworld', confirmed_at: '2016-08-14')
admin.remove_role :free
admin.add_role :admin

puts "Seed finished!"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
