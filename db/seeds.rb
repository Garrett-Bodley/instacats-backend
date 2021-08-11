puts "Creating 50 users."
50.times do
  username = Faker::Internet.unique.username(separators: %w(. _ -))
  email = Faker::Internet.unique.email(name: username)

  User.create(username: username, email: email, password: "password")
end

puts "Assigning a User to each CatPic"
CatPic.all.each do |pic|
  pic.user = User.get_random
  pic.save
end

puts "Creating Comments for each Pic."
CatPic.all.each do |pic|
  rand(4).times do
    user = User.get_random
    text = Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 3)

    Comment.create(user: user, text: text, cat_pic: pic)
  end
end

puts "Make each User like 5 Pics and 5 Comments."
User.all.each do |user|
  5.times do
    Like.create(user: user, likeable: CatPic.get_random)
    Like.create(user: user, likeable: Comment.get_random)
  end
end