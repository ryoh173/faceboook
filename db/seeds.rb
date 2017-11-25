# 100.times do |n|
#   y = 1
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(email: email,
#                password: "password",
#                uid: y,
#                provider: "Facebook"
#                )
#   y = y + 1
# end

# n = 10
# while n <= 100
#   email = Faker::Internet.email
#   User.create!(email: email,
#                password: "password",
#                uid: n,
#                provider: "Facebook"
#                )
#   n = n + 1
# end

10.times do |n|
  name  = Faker::Friends.character
  email = Faker::Internet.email
  password = Faker::Internet.password
  uid   = SecureRandom.uuid
  avatar = Faker::Avatar.image("my-own-slug", "50x50", "jpg")
  title = Faker::Lorem.sentence
  content = Faker::Lorem.sentence

  user = User.create!(
  	  name: name,
  	  email: email,
	    password: password,
	    password_confirmation: password,
	    uid: uid,
      avatar: avatar
	  )

  topic = Topic.new(
    title: title,
    content: content,
    user_id: user.id
    )

  topic.comments.build(
    content: 'Hello',
    user_id: user.id)
  topic.save
 end

# n = 10
# while n <= 100
#   Topic.create(
#     title: "Hello",
#     content: "World",
#     user_id: n
#   )
#   n = n + 1
# end

# n = 10
# while n <= 100
#   Comment.create(
#     user_id: n,
#     topic_id: n,
#     content: "comment"
#   )
#   n = n + 1
# end
