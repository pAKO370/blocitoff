include Faker

user1 = User.create!(
  username: 'user1',
  email: 'pfluegelcx@gmail.com',
  password: 'helloworld',
  )
user2 = User.create!(
  username: 'user2',
  email: 'gsxr370k6@yahoo.com',
  password: 'helloworld',
  )
user1.skip_confirmation!
user1.save!
user2.skip_confirmation!
user2.save!
users = User.all

10.times do

  Item.create!(
  user: users.sample,
  name: Faker::Lorem.sentence
)
end
puts "#{User.count} users created"
puts "#{Item.count} items created"