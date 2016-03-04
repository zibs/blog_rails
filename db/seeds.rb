# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:

#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
["Pop Poetry", "Poetics", "Pseudo Poetics", "Poesy", "Poetic Technologies", "The Poetry of Innovation"].each do |cat|
  Category.create(title: cat)
end

25.times do
  user = User.create(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.email,
                      password: "123123", password_confirmation: "123123")
 10.times do
   user.posts.create(title: Faker::Book.title,
                   body: Faker::Hipster.paragraph(3),
                   category: Category.all.sample)

 end

end

User.all.each do |user|
  Post.all.each do |post|
    comment = Comment.new(body: Faker::Hacker.say_something_smart)
    comment.post = post
    comment.user = user
    comment.save
  end
end
