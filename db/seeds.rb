# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
category_names = ['ruby', 'java', 'js', 'c++']
category_names.each { |name| PostCategory.create(name: name) }
categories = PostCategory.all

5.times do |i|
  user = User.create!(email: "#{Faker::Lorem.word}@mail.com", password: '#$taawktljasktlw4aaglj', password_confirmation: '#$taawktljasktlw4aaglj')
  10.times do |j|
    user.posts.create!(title: Faker::Lorem.word, body: Faker::Lorem.sentence(word_count: 100), creator: user, post_category: categories.sample)
  end
end
