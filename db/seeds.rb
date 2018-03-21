# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ name: 'Pavel' }, { name: 'Tester' }])
thread = CommentThread.create()

thread.comments << Comment.new({ text: "Top level comment", user: users[0] })
thread.comments << Comment.new({ text: "Another Top level comment", user: users[0] })

thread.comments[0].comments << Comment.new({ text: 'Answer to first one', user: users[1] })
thread.comments[1].comments << Comment.new({ text: 'Answer to second one', user: users[1] })

thread.comments[0].comments[0].comments << Comment.new({ text: 'Reply to first answer', user: users[0] })
