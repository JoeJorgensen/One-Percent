# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
u1 = User.create(name: 'John', email: 'John@test.com', password: '123456')
u2 = User.create(name: 'Thor', email: 'thor@test.com', password: '123456')




posts = Post.create([{title: 'Favorite Philosophers', description:'My list of my favorite philosophers', user_id:1, id:1}])
comments = Comment.create([{content: 'Yeah same', post_id:1, id:1}])